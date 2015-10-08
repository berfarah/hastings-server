class TaskDispatcher
  attr_reader :task

  def initialize(task)
    @task = task
  end

  def running?
    !@task.instances.where.not(job_id: nil).exists?
  end

  def failed?
    @task.instances.last.failed
  end

  def queue
    "#{@task.name.parameterize}_#{@task.id}"
  end

  def run_now
    instance = Task::NowJob.new(schedule_opts.except(:run_at, :run_every))
    return false if instance.exist?
    Delayed::Job.enqueue instance, queue: queue
  end

  def update_schedule
    return unschedule unless @task.enabled
    Task::RecurringJob.schedule(schedule_opts)
  end

  def unschedule
    Task::RecurringJob.unschedule(schedule_opts)
  end

  def pause
    Task::RecurringJob.pause(schedule_opts)
  end

  def unpause
    Task::RecurringJob.unpause(schedule_opts)
  end

  private

    def schedule_opts
      { task: @task,
        run_at: Time.zone.parse(@task.run_at),
        run_every: @task.run_every,
        script: @task.script.path,
        queue: queue }
    end
end
