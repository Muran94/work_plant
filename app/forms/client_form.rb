class ClientForm < ApplicationForm
  self.model_names = %i(client contract)

  def initialize_models
    @client   ||= Client.new
    @contract ||= Contract.find_or_initialize_by(client: client)
    @models     = [client, contract]
  end
end