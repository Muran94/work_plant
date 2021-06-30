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
FactoryBot.define do
  factory :contract do
    ### Associations
    association :client


    ### Attributes
    expired_at     { nil }
    expired_reason { nil }
    hourly_payment { 3000 }



    ### Traits
    trait :active do
      expired_at     { nil }
      expired_reason { nil }
    end

     trait :finished do
      expired_reason { :finish }
     end

     trait :renewed do
      expired_reason { :renew }
     end


    ### Callbacks
  end
end
