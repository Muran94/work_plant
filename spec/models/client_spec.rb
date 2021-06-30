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
require 'rails_helper'

RSpec.describe Client, type: :model do
  subject { build_stubbed(:client) }

  describe 'Instantiate' do
    it '正常にインスタンスを作成できること' do
      expect(create_list(:client, 3)).to be_truthy
    end
  end


  describe 'Constants'


  describe 'Modules'


  describe 'Associations' do
    it 'belongs_to :user' do
      expect(subject).to belong_to(:user)
    end

    it 'has_many :contracts, dependent: :destroy' do
      expect(subject).to have_many(:contracts).dependent(:destroy)
    end

    it 'has_many :activity_logs, through: :contracts' do
      expect(subject).to have_many(:activity_logs).through(:contracts)
    end
  end


  describe 'Callbacks'


  describe 'Enums'


  describe 'Delegations'


  describe 'Validations' do
    it 'validates :name, presence: true, length: { maximum: MAXIMUM_NAME_LENGTH }' do
      expect(subject).to validate_presence_of(:name)
      expect(subject).to validate_length_of(:name).is_at_most(Client::MAXIMUM_NAME_LENGTH)
    end
  end


  describe 'Scopes'


  describe 'Class Methods'


  describe 'Getters, Setters'


  describe 'Instance Methods' do
    describe '#active_contract' do
      it '有効な契約を1件返す' do
        client = create(:client)
        contracts = [
          create(:contract, :active,   client: client),
          create(:contract, :finished, client: client)
        ]

        expect(client.active_contract).to eq contracts.first
      end
    end

    describe '#contract_expired?' do
      it '有効な契約が一件でもあればfalse、全ての契約が終了済みならtrueを返す' do
        # 有効な契約が存在するケース
        client = create(:client)
        contracts = [
          create(:contract, :active,   client: client),
          create(:contract, :finished, client: client)
        ]

        expect(client.contract_expired?).to be_falsy

        # 全ての契約が終了しているケース
        client = create(:client)
        contracts = [
          create(:contract, :finished, client: client),
          create(:contract, :finished, client: client)
        ]

        expect(client.contract_expired?).to be_truthy
      end
    end

    describe '#current_activity_status' do

    end

    describe '#todays_total_activity_seconds' do

    end

    describe '#todays_total_payment' do

    end

    describe '#todays_total_payment_including_tax' do

    end
  end


  describe 'Private Methods'
end
