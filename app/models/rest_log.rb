# == Schema Information
#
# Table name: rest_logs
#
#  id                        :bigint           not null, primary key
#  finished_at(休憩終了日時) :datetime         indexed
#  started_at(休憩開始日時)  :datetime         indexed
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  activity_log_id           :bigint           not null, indexed
#
# Indexes
#
#  index_rest_logs_on_activity_log_id  (activity_log_id)
#  index_rest_logs_on_finished_at      (finished_at)
#  index_rest_logs_on_started_at       (started_at)
#
# Foreign Keys
#
#  fk_rails_...  (activity_log_id => activity_logs.id)
#
class RestLog < ApplicationRecord
  ### Constants



  ### Modules



  ### Associations
  belongs_to :activity_log



  ### Callbacks



  ### Enums



  ### Delegations



  ### Validations
  validates :started_at, presence: true
  # TODO: started_atと、finished_atは、紐づくActivityLogのstarted_atと、finished_atに収まっていなければならない。



  ### Scopes

  # 休憩終了済みのコレクションを返す
  scope :finished, -> { where.not(finished_at: nil) }

  # 休憩中のコレクションを返す
  scope :resting, -> { where(finished_at: nil) }



  ### Class Methods



  ### Getters, Setters



  ### Instance Methods

  # 休憩を終了する
  # ==== 戻り値
  # true or false
  def finish
    update(finished_at: Time.zone.now)
  end

  # 休憩を終了する
  # ==== 戻り値
  # true or raise ActiveRecord::RecordInvalid
  def finish!
    update!(finished_at: Time.zone.now)
  end

  # 休憩終了済みか否か
  def finished?
    finished_at.present?
  end

  # まだ休憩中か否か
  def still_resting?
    finished_at.blank?
  end

  # 合計休憩時間（second）
  def total_rest_seconds
    _calc_total_rest_seconds
  end

  private

  # 合計休憩時間(second)を計算する
  def _calc_total_rest_seconds
    return 0 unless finished?
    finished_at - started_at
  end
end
