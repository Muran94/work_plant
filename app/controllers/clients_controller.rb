class ClientsController < ApplicationController
  before_action :_set_client, only: %i[show edit update destroy]

  def index
    @clients                            = current_user.clients
    @todays_total_activity_seconds      = current_user.todays_total_activity_seconds
    @todays_total_payment_including_tax = current_user.todays_total_payment_including_tax
  end

  def show
    @activity_logs                      = @client.active_contract&.activity_logs.order(started_at: :desc)
    @activity_log_currently_operating   = @client.active_contract&.activity_logs&.operating&.first
    @rest_log_currently_resting         = @activity_log_currently_operating&.rest_logs&.resting&.first
    @todays_total_activity_seconds      = @client.todays_total_activity_seconds
    @todays_total_payment_including_tax = @client.todays_total_payment_including_tax
  end

  def new
    @client_form = ClientForm.new
  end

  def create
    @client_form =
      ClientForm.new(
        client_attributes: _client_params,
        contract_attributes: _contract_params
      )

    if @client_form.save
      flash[:notice] = "案件を追加しました。"
      redirect_to @client_form.client
    else
      flash.now[:alert] = "案件の追加に失敗しました。"
      render :new
    end
  end

  def edit
    @client_form = ClientForm.new(client: @client)
  end

  def update
    @client_form =
      ClientForm.new(
        client: @client,
        client_attributes: _client_params,
        contract_attributes: _contract_params
      )

    if @client_form.save
      flash[:notice] = "保存しました。"
      redirect_to @client_form.client
    else
      flash.now[:alert] = "保存に失敗しました。"
      render :new
    end
  end

  def destroy
  end

  private

  def _client_form_params
    params.require(:client_form)
  end

  def _client_params
    _client_params = {}
    _client_params = _client_params.merge(_client_form_params.require(:client).permit(:name, :logo))
    _client_params = _client_params.merge(user_id: current_user.id)
    _client_params
  end

  def _contract_params
    _client_form_params.require(:contract).permit(:hourly_payment)
  end

  def _set_client
    @client = Client.find(params[:id])
  end
end
