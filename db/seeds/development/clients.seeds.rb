after "development:users" do
  user = User.first

  Client.find_or_create_by!(name: "スパイスファクトリー株式会社", user: user)
  Client.find_or_create_by!(name: "株式会社スムーズ", user: user)
end