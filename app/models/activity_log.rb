# == Schema Information
#
# Table name: activity_logs
#
#  id                        :bigint           not null, primary key
#  comment(稼働内容等)       :text
#  finished_at(終了時間)     :datetime         indexed
#  payment(報酬額（税抜き）) :integer          not null
#  started_at(開始時間)      :datetime         not null, indexed
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  contract_id               :bigint           not null, indexed
#
# Indexes
#
#  index_activity_logs_on_contract_id  (contract_id)
#  index_activity_logs_on_finished_at  (finished_at)
#  index_activity_logs_on_started_at   (started_at)
#
# Foreign Keys
#
#  fk_rails_...  (contract_id => contracts.id)
#
class ActivityLog < ApplicationRecord
  ### Constants
  HOUR   = 3_600
  MINUTE = 60
  SECOND = 1



  ### Modules



  ### Associations
  belongs_to :contract
  has_many :rest_logs, dependent: :destroy



  ### Callbacks
  before_validation :_set_payment



  ### Enums



  ### Delegations



  ### Validations
  validates :payment, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :started_at, presence: true
  # TODO: started_atとfinished_atの整合性保証



  ### Scopes
  # 稼働が終了しているコレクションを返す
  scope :finished,  -> { where.not(finished_at: nil) }

  # 稼働中のコレクションを返す
  scope :operating, -> { where(finished_at: nil) }

  # 本日の稼働コレクションを返す
  scope :todays,    -> { where(started_at: Time.zone.now.all_day) }



  ### Class Methods
  # 直近の稼働（ActivityLogオブジェクト）を1件返す
  def self.latest
    last
  end



  ### Getters, Setters



  ### Instance Methods

  # 稼働を終了する
  def finish
    unfinished_rest_log = rest_logs.resting.first

    ActiveRecord::Base.transaction do
      unfinished_rest_log.finish! if unfinished_rest_log.present? # 終了していないRestLogが存在していたら、ついでに終了させる。
      update!(finished_at: Time.zone.now)
    end

    true
  rescue => e
    # TODO: ロガーを仕込む
    false
  end

  # 稼働が終了しているか否か
  def finished?
    finished_at.present?
  end

  # 稼働中か否か
  def operating?
    finished_at.blank?
  end

  # 稼働による報酬額を返す（税込）
  def payment_including_tax
    Utils::JapanTaxCalculator.price_including_tax(payment)
  end

  # 休憩中か否か
  def resting?
    operating? && rest_logs.any?(&:still_resting?)
  end

  # 稼働を開始する
  def start
    update(started_at: Time.zone.now)
  end

  # 稼働秒数
  def total_activity_seconds
    _calc_total_activity_seconds.ceil
  end



  private

  # 稼働に伴う報酬を計算して返す
  def _calc_payment
    return 0 unless finished?
    (contract.hourly_payment * _calc_total_activity_seconds.fdiv(HOUR)).ceil
  end

  # 稼働に伴う報酬を計算した上で、paymentカラムにセットする
  def _set_payment
    self.payment = _calc_payment
  end

  # 休憩時間を除く実稼働時間（hour）を返す
  def _calc_total_activity_hours
    return 0 unless finished?
    _calc_total_activity_seconds.fdiv(HOUR)
  end

  # 休憩時間を除く実稼働時間（minute）を返す
  def _calc_total_activity_minutes
    return 0 unless finished?
    _calc_total_activity_seconds.fdiv(MINUTE)
  end

  # 休憩時間を除く実稼働時間（second）を返す
  def _calc_total_activity_seconds
    return 0 unless finished?
    (finished_at - started_at) - _calc_total_rest_seconds
  end

  # 合計休憩時間（second）を返す
  def _calc_total_rest_seconds
    rest_logs.finished.map(&:total_rest_seconds).inject(&:+) || 0
  end
end
