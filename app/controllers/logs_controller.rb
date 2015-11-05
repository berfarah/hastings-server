# Logs Controller
class LogsController < ApplicationController
  def index
    @logs =
      LogsPresenter.new(
        Log.page(params[:page]).per(20)
        .includes(:loggable)
      )
  end

  def search
    @logs =
      LogsPresenter.new(
        LogsSearch.new(search_params).search
        .page(params[:page]).per(20)
      )
    render :index
  end

  private

    def search_params
      params.permit(:query, :name, :from, :to)
    end
end
