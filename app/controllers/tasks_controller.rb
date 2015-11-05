class TasksController < ApplicationController
  include UpdateTracking

  def index
    @tasks = Task.order("LOWER(name) ASC").includes(:instances).page(params[:page]).per(12)
  end

  # TODO: Implement streaming - relies on
  # include ActionController::Live
  # def events
  #   response.headers["Content-Type"] = "text/event-stream"
  #   redis = Redis.new
  #   redis.subscribe("tasks.touch") do |on|
  #     on.message do |_event, data|
  #       response.stream.write("data: #{data}\n\n")
  #     end
  #   end
  # rescue IOError
  #   puts "Stream closed"
  # ensure
  #   redis.quit
  #   response.stream.close
  # end

  def show
    @task = TaskPresenter.new(
      Task.includes(:instances).find(params[:id]),
      Log.by_task(params[:id]).page(params[:page]).per(20)
    )
  end

  def new
    @task = Task.new
  end

  def toggle
    @task = find_task
    @task.enabled = !@task.enabled
    # TODO: Separate this into decorator
    on = @task.enabled ? "enabled" : "disabled"
    @task.save
    redirect_to :back, notice: "#{@task.name} has been #{on}"
  end

  def run_now
    @task = find_task
    # TODO: Separate this into decorator
    on = TaskDispatcher.new(@task).run_now ? "running now" : "already running"
    redirect_to :back, notice: "#{@task.name} is #{on}"
  end

  def edit
    @task = find_task
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    if @task.save
      redirect_to @task, notice: "Task was successfully created."
    else
      flash[:error] = @task.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @task = find_task
    if @task.update(task_params)
      track_update(@task)
      redirect_to @task, notice: "Task was successfully updated."
    else
      flash[:error] = @task.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @task = find_task
    @task.destroy
    redirect_to tasks_url, notice: "Task was successfully destroyed."
  end

  private

    def find_task
      Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :script, :external, :ip, :scalar,
                                   :interval, :run_at, :enabled)
    end
end
