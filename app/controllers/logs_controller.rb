# Logs Controller
class LogsController < ApplicationController
  def index
    @logs =
      Log.order(created_at: :desc)
      .page(params[:page]).per(20)
      .includes(:loggable)

    @grouped_logs = grouped_logs
  end

  def search
    @logs =
      LogsSearch.new(
        query: params[:query],
        name: params[:name],
        from: params[:from],
        to: params[:to]
      ).search.page(params[:page]).per(20)

    @grouped_logs = grouped_logs
    render :index
  end

  private

    def grouped_logs
      @logs.group_by { |l| l.loggable.try(:name) }
    end
end
