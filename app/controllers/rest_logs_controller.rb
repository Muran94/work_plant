class RestLogsController < ApplicationController
  before_action :_set_client, :_set_activity_log
  before_action :_set_rest_log

  def start
    @rest_log = @activity_log&.rest_logs&.build(started_at: Time.zone.now)

    if @rest_log.save
      flash[:notice] = "休憩を開始しました。"
    else
      flash[:alert] = "エラーが発生しました。"
    end

    redirect_to client_path(@client)
  end

  def edit
  end

  def update
  end

  def finish
    if @rest_log.finish
      flash[:notice] = "休憩を終了しました。"
    else
      flash[:alert] = "エラーが発生しました。"
    end

    redirect_to client_path(@client)
  end

  def destroy
  end

  private

  def _set_client
    @client = current_user.clients.find(params[:client_id])
  end

  def _set_activity_log
    @activity_log = @client.active_contract&.activity_logs&.find(params[:activity_log_id])
  end

  def _set_rest_log
    @rest_log = @activity_log.rest_logs.find(params[:id])
  end
end
