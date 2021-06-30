# == Schema Information
#
# Table name: contracts
#
#  id                           :bigint           not null, primary key
#  expired_at(契約終了日時)     :datetime
#  expired_reason(契約終了理由) :integer
#  hourly_payment(時給（税抜）) :integer          not null
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  client_id                    :bigint           not null, indexed
#
# Indexes
#
#  index_contracts_on_client_id  (client_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => clients.id)
#

# 契約を表すモデルクラス
class Contract < ApplicationRecord
  ### Constants



  ### Modules



  ### Associations
  belongs_to :client
  has_many :activity_logs, dependent: :destroy



  ### Callbacks



  ### Enums
  enum expired_reason: {
    finish: 0, # 終了
    renew: 10, # 更新
  }



  ### Delegations



  ### Validations
  validates :hourly_payment, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }



  ### Scopes
  # 有効な契約のコレクションを返す
  scope :active, -> { where(expired_at: nil, expired_reason: nil) }



  ### Class Methods



  ### Getters, Setters



  ### Instance Methods
  # 契約を終了する
  def finish
    self.update(expired_at: Time.zone.now, expired_reason: :finish)
  end

  # 時給（税込）
  def hourly_payment_including_tax
    Utils::JapanTaxCalculator.price_including_tax(hourly_payment)
  end
end
