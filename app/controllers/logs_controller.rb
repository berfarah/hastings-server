# Logs Controller
class LogsController < ApplicationController
  before_action :set_log, only: [:show, :edit, :update, :destroy]

  # GET /logs
  # GET /logs.json
  def index
    @logs = Log.order(created_at: :desc)
               .page(params[:page]).per(20)
               .includes(:loggable)
    @grouped_logs = @logs.group_by { |l| l.loggable.try(:name) }
  end

  def search
    @logs = Log.search(params[:query]).page(params[:page]).per(50)
    render :index
  end

  def date
    date = Date.parse(params[:date]).in_time_zone(-7)
    @logs = Log.date(date)
    @logs = @logs.where(severity: params[:filter]) if params[:filter]

    render :index
  end

  # GET /logs/1
  def show
  end

  private

    def full_day(date)
      date.beginning_of_day..date.end_of_day
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_params
      params.require(:log).permit(:severity, :message, :task_id)
    end
end
