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
require "test_helper"

class ContractTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
