after "development:clients" do
  clients = Client.all

  clients.each do |client|
    next if %w[Mtame株式会社 quatre株式会社].include?(client.name)
    Contract.find_or_create_by!(hourly_payment: 4_200, client: client)
  end
end