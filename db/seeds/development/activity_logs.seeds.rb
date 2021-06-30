after "development:contracts" do
  # スパイスファクトリー株式会社
  contract = Contract.first
  contract.activity_logs.create!(started_at: Time.zone.parse('2021/06/14 11:00:00'), finished_at: Time.zone.parse('2021/06/14 11:05:00'))
  contract.activity_logs.create!(started_at: Time.zone.parse('2021/06/15 10:30:00'), finished_at: Time.zone.parse('2021/06/15 11:05:00'))
  contract.activity_logs.create!(started_at: Time.zone.parse('2021/06/16 10:00:00'), finished_at: Time.zone.parse('2021/06/16 14:07:00')) do |activity_log|
    RestLog.create!(started_at: Time.zone.parse('2021/06/16 11:10:00'), finished_at: Time.zone.parse('2021/06/16 12:30:00'), activity_log: activity_log)
  end
  contract.activity_logs.create!(started_at: Time.zone.parse('2021/06/22 10:00:00'), finished_at: Time.zone.parse('2021/06/22 19:30:00'))
  contract.activity_logs.create!(started_at: Time.zone.parse('2021/06/28 12:20:00'), finished_at: Time.zone.parse('2021/06/28 13:30:00'))
  contract.activity_logs.create!(started_at: Time.zone.parse('2021/06/28 17:30:00'), finished_at: Time.zone.parse('2021/06/28 21:30:00')) do |activity_log|
    RestLog.create!(started_at: Time.zone.parse('2021/06/28 17:55:00'), finished_at: Time.zone.parse('2021/06/28 19:30:00'), activity_log: activity_log)
    RestLog.create!(started_at: Time.zone.parse('2021/06/28 19:45:00'), finished_at: Time.zone.parse('2021/06/28 19:50:00'), activity_log: activity_log)
    RestLog.create!(started_at: Time.zone.parse('2021/06/28 19:55:00'), finished_at: Time.zone.parse('2021/06/28 20:30:00'), activity_log: activity_log)
  end

  # 株式会社スムーズ
  contract = Contract.second
  contract.activity_logs.create!(started_at: Time.zone.parse('2021/06/15 13:30:00'), finished_at: Time.zone.parse('2021/06/15 15:15:00'))
  contract.activity_logs.create!(started_at: Time.zone.parse('2021/06/17 8:30:00'), finished_at: Time.zone.parse('2021/06/17 11:00:00'))
  contract.activity_logs.create!(started_at: Time.zone.parse('2021/06/21 21:30:00'), finished_at: Time.zone.parse('2021/06/22 00:30:00'))
  contract.activity_logs.create!(started_at: Time.zone.parse('2021/06/23 13:30:00'), finished_at: Time.zone.parse('2021/06/23 15:00:00'))
  contract.activity_logs.create!(started_at: Time.zone.parse('2021/06/24 10:10:00'), finished_at: Time.zone.parse('2021/06/24 18:00:00')) do |activity_log|
    RestLog.create!(started_at: Time.zone.parse('2021/06/24 11:30:00'), finished_at: Time.zone.parse('2021/06/24 12:00:00'), activity_log: activity_log)
    RestLog.create!(started_at: Time.zone.parse('2021/06/24 13:08:00'), finished_at: Time.zone.parse('2021/06/24 16:30:00'), activity_log: activity_log)
  end
  contract.activity_logs.create!(started_at: Time.zone.parse('2021/06/28 10:30:00'), finished_at: Time.zone.parse('2021/06/28 12:00:00'))
end 