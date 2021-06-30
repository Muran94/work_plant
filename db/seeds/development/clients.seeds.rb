after "development:users" do
  user = User.first

  Client.find_or_create_by!(name: "スパイスファクトリー株式会社", user: user) do |client|
    client.logo = File.open(Rails.root.join("db/seeds/fixtures/images/spice-logo.jpeg"))
  end

  Client.find_or_create_by!(name: "株式会社スムーズ", user: user) do |client|
    client.logo = File.open(Rails.root.join("db/seeds/fixtures/images/smooth-logo.jpeg"))
  end

  Client.find_or_create_by!(name: "Mtame株式会社", user: user) do |client|
    client.logo = File.open(Rails.root.join("db/seeds/fixtures/images/mtame-logo.png"))
  end

  Client.find_or_create_by!(name: "quatre株式会社", user: user) do |client|
    client.logo = File.open(Rails.root.join("db/seeds/fixtures/images/quatre-logo.png"))
  end
end