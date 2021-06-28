# == Schema Information
#
# Table name: activity_logs
#
#  id          :bigint           not null, primary key
#  contract_id :bigint           not null
#  payment     :integer          not null
#  start_at    :datetime
#  end_at      :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ActivityLog < ApplicationRecord
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

  ### Scopes

  ### Class Methods
  class << self
  end

  ### Instance Methods
  def payment_including_tax
    Utils::JapanTaxCalculator.price_including_tax(payment)
  end

  private

  def _calc_payment
    return 0 if start_at.nil? || end_at.nil?
    (contract.hourly_wage * _total_activity_seconds.fdiv(HOUR)).ceil
  end

  def _set_payment
    self.payment = _calc_payment
  end

  # 休憩時間を除く実稼働時間（時間）
  def _total_activity_hours
    _total_activity_seconds.fdiv(HOUR)
  end

  # 休憩時間を除く実稼働時間（分）
  def _total_activity_minutes
    _total_activity_seconds.fdiv(MINUTE)
  end

  # 休憩時間を除く実稼働時間（秒）
  def _total_activity_seconds
    (end_at - start_at) - _total_rest_seconds
  end

  def _total_rest_seconds
    rest_logs.inject(0) do |total_rest_time, rest_log|
      rest_log.end_at - rest_log.start_at
    end
  end
end
