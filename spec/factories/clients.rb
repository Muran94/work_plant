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
FactoryBot.define do
  factory :client do
    ### Associations
    association :user


    ### Attributes
    name { "HOGEHOGE株式会社" }


    ### Traits


    ### Callbacks
  end
end
