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
require "test_helper"

class ActivityLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
