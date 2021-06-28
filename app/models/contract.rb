# == Schema Information
#
# Table name: contracts
#
#  id          :bigint           not null, primary key
#  client_id   :bigint           not null
#  hourly_wage :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Contract < ApplicationRecord
  TAX_RATE = 0.1

  ### Modules

  ### Associations
  belongs_to :client
  has_many :activity_logs, dependent: :destroy
  
  ### Callbacks

  ### Enums

  ### Delegations

  ### Validations
  validates :hourly_wage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  ### Scopes

  ### Class Methods
  class << self
  end

  ### Instance Methods
  def hourly_wage_including_tax
     Utils::JapanTaxCalculator.price_including_tax(hourly_wage)
  end
end
