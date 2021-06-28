after "development:clients" do
  clients = Client.all

  clients.each do |client|
    Contract.find_or_create_by!(hourly_wage: 4_200, client: client)
  end
end