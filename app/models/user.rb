# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null, indexed
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string           indexed
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  ### Constants



  ### Modules
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable



  ### Associations
  has_many :clients, dependent: :destroy



  ### Callbacks



  ### Enums



  ### Delegations



  ### Validations



  ### Scopes



  ### Class Methods



  ### Getters, Setters



  ### Instance Methods
  # 本日の合計稼働時間（second）
  def todays_total_activity_seconds
    clients.inject(0) do |total_activity_seconds, client|
      client.todays_total_activity_seconds
    end
  end

  # 本日の合計稼働報酬（税込）
  def todays_total_payment_including_tax
    todays_total_payment =
      clients.inject(0) do |total_payment, client|
        client.todays_total_payment
      end

    Utils::JapanTaxCalculator.price_including_tax(todays_total_payment)
  end
end
