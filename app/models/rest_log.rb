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
class RestLog < ApplicationRecord
  belongs_to :activity_log
end
