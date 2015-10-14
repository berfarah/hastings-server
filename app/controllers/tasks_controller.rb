# Controller
class TasksController < ApplicationController
  include ActionController::Live
  before_action :set_task, only: [:edit, :update, :destroy, :toggle]
  before_action :set_task_with_instances, only: [:show, :run_now]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.order('LOWER(name) asc').page(params[:page]).per(12).includes(:instances)
  end

  def search
    @tasks = Task.search(params[:query]).records.includes(:instances).page(params[:page]).per(12)
    render :index
  end

  def events
    response.headers["Content-Type"] = "text/event-stream"
    redis = Redis.new
    redis.subscribe("tasks.touch") do |on|
      on.message do |_event, data|
        response.stream.write("data: #{data}\n\n")
      end
    end
  rescue IOError
    puts "Stream closed"
  ensure
    redis.quit
    response.stream.close
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @logs = Log.includes(:instance)
               .where(instances: { task_id: params[:id] })
               .page(params[:page]).per(20)
    # @grouped_logs = @logs.group_by { |l| l.instance.created_at.to_date }
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
    on = TaskDispatcher.new(@task).run_now ? "running now" : "already running"
    respond_to do |format|
      format.html { redirect_to :back, notice: "#{@task.name} is #{on}" }
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

    def set_task_with_instances
      @task = Task.includes(:instances).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :script, :external, :ip, :scalar, :interval, :run_at, :enabled)
    end

    def not_authenticated
      render json: 'Not an authenticated IP address'.to_json, status: :forbidden
    end
end
