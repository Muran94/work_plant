# == Schema Information
#
# Table name: clients
#
#  id         :bigint           not null, primary key
#  logo_data  :text
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null, indexed
#
# Indexes
#
#  index_clients_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

# 企業様を表すモデルクラス
class Client < ApplicationRecord
  ### Constants
  MAXIMUM_NAME_LENGTH = 64


  ### Modules
  include ClientLogoUploader::Attachment(:logo)


  ### Associations
  belongs_to :user
  has_many :contracts, dependent: :destroy
  has_many :activity_logs, through: :contracts


  ### Callbacks
  before_validation :_resize_logo_size


  ### Enums


  ### Delegations


  ### Validations
  validates :name, presence: true, length: { maximum: MAXIMUM_NAME_LENGTH }


  ### Scopes


  ### Class Methods


  ### Getters, Setters


  ### Instance Methods
  # 有効な契約(Contractオブジェクト）を返す
  def active_contract
    contracts.active.first
  end

  # 契約終了か否か
  def contract_expired?
    contracts.all? { |contract| contract.expired_at.present? }
  end

  # 現在の稼働状況
  # ==== 戻り値
  # operating、resting、offの3つの内、どれかをシンボルで返す。
  # * +operating+ - 稼働中
  # * +resting+   - 休憩中
  # * +off+       - 無稼働
  def current_activity_status
    latest_activity_log =  active_contract&.activity_logs&.latest

    return :off     if latest_activity_log.blank? || latest_activity_log&.finished?
    return :resting if latest_activity_log.resting?
    :operating
  end

  # 本日稼働分の合計稼働秒数
  def todays_total_activity_seconds
    activity_logs.todays.finished.map(&:total_activity_seconds).inject(&:+) || 0
  end

  # 本日稼働分の合計報酬（税抜）
  def todays_total_payment
    activity_logs.todays.finished.pluck(:payment).inject(&:+) || 0
  end

  # 本実稼働分の合計報酬（税込）
  def todays_total_payment_including_tax
     Utils::JapanTaxCalculator.price_including_tax(todays_total_payment)
  end

  private

  # アップロードされたロゴ画像のリサイズ処理
  def _resize_logo_size
    logo_derivatives! if will_save_change_to_logo_data?
  end
end
