# == Schema Information
#
# Table name: clients
#
#  id                 :bigint           not null, primary key
#  user_id            :bigint           not null
#  name               :string           not null
#  contact_expired_at :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Client < ApplicationRecord
  ### Modules

  ### Associations
  belongs_to :user
  has_many :contracts, dependent: :destroy
  has_many :activity_logs, through: :contracts

  ### Callbacks

  ### Enums

  ### Delegations

  ### Validations
  validates :name, presence: true

  ### Scopes

  ### Class Methods
  class << self
  end

  ### Instance Methods
  def todays_total_payment
    activity_logs.where(start_at: Time.zone.now.all_day).pluck(:payment).inject(&:+)
  end

  def todays_total_payment_including_tax
     Utils::JapanTaxCalculator.price_including_tax(todays_total_payment)
  end
end
