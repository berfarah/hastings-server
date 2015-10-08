class InstancesController < ApplicationController
  before_action :set_instance, only: [:show, :edit, :update, :destroy]

  # GET /instances
  def index
    @instances = Instance.where(task: params[:task_id])
  end

  # GET /instances/1
  def show
  end

  def search
    @logs = Log.where(loggable_id: params[:id], loggable_type: "Instance").search(params[:query]).page(params[:page]).per(40)
    render "logs/index"
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_instance
      @instance = Instance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instance_params
      params.require(:instance).permit(:finished_at, :failed, :task_id)
    end
end
