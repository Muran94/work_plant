# == Schema Information
#
# Table name: rest_logs
#
#  id              :bigint           not null, primary key
#  activity_log_id :bigint           not null
#  start_at        :datetime
#  end_at          :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "test_helper"

class RestLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
