class ActivityLogsController < ApplicationController
  before_action :_set_client
  before_action :_set_activity_log, only: %i[edit update finish destroy]

  def start
    @activity_log = @client.active_contract&.activity_logs&.build

    if @activity_log.start
      flash[:notice] = "稼働を開始しました。"
    else
      flash[:alert] = "エラーが発生しました。"
    end

    redirect_to client_path(@client)
  end

  def new

  end

  def create

  end

  def edit
  end

  def update
    if @activity_log.update(_activity_log_params)
      flash[:notice] = ""
    else

    end
  end

  def finish
    if @activity_log.finish
      flash[:notice] = "稼働を終了しました。"
    else
      flash[:alert] = "エラーが発生しました。"
    end

    redirect_to client_path(@client)
  end

  def destroy
  end

  private

  def _activity_log_params
    params.require(:activity_log).permit(:started_at, :finished_at)
  end

  def _set_client
    @client = current_user.clients.find(params[:client_id])
  end

  def _set_activity_log
    @activity_log = @client.active_contract&.activity_logs.find(params[:id])
  end
end
