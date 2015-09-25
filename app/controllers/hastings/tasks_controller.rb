require_dependency "hastings/application_controller"

module Hastings
  # Controller
  class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle, :run_now]
    skip_before_action :verify_authenticity_token, only: :external

    def external
      return not_authenticated unless (@task = Task.find_by_ip(request.ip))
      log = @task.external_log(params.require(:log).permit(:severity, :message))

      if log.save
        render json: log.to_json
      else
        render json: { errors: log.errors }.to_json, status: :bad_request
      end
    end

    # GET /tasks
    # GET /tasks.json
    def index
      @tasks = Task.search(params[:search], :name)
    end

    def internal
      @tasks = Task.where(external: false).search(params[:search], :name)
      render template: 'hastings/tasks/index'
    end

    def external
      @tasks = Task.where(external: true).search(params[:search], :name)
      render template: 'hastings/tasks/index'
    end

    def search
      @tasks = Task.search(params[:search_query])
    end

    # GET /tasks/1
    # GET /tasks/1.json
    def show
    end

    # GET /tasks/new
    def new
      @task = Task.new
    end

    def toggle
      @task.enabled = !@task.enabled
      on = @task.enabled ? "enabled" : "disabled"
      @task.save
      respond_to do |format|
        format.html { redirect_to :back, notice: "#{@task.name} has been #{on}" }
        format.json { head :no_content }
      end
    end

    def run_now
      on = @task.run_now ? "is running now" : "was already running"
      respond_to do |format|
        format.html { redirect_to :back, notice: "#{@task.name} #{on}" }
        format.json { head :no_content }
      end
    end

    # GET /tasks/1/edit
    def edit
    end

    # POST /tasks
    # POST /tasks.json
    def create
      @task = Task.new(task_params)

      respond_to do |format|
        if @task.save
          format.html { redirect_to @task, notice: 'Task was successfully created.' }
          format.json { render :show, status: :created, location: @task }
        else
          flash[:error] = @task.errors.full_messages.to_sentence
          format.html { render :new }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /tasks/1
    # PATCH/PUT /tasks/1.json
    def update
      respond_to do |format|
        if @task.update(task_params)
          format.html { redirect_to @task, notice: 'Task was successfully updated.' }
          format.json { render :show, status: :ok, location: @task }
        else
          flash[:error] = @task.errors.full_messages.to_sentence
          format.html { render :edit }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /tasks/1
    # DELETE /tasks/1.json
    def destroy
      @task.destroy
      respond_to do |format|
        format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def instances
      @task = Task.find(params[:task_id])
    end

    private

      # Use callbacks to share common setup or constraints between actions.
      def set_task
        @task = Task.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def task_params
        params.require(:task).permit(:name, :script, :external, :ip, :scalar, :interval, :run_at, :enabled)
      end

      def not_authenticated
        render json: 'Not an authenticated IP address'.to_json, status: :forbidden
      end
  end
end
