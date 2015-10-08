class Task
  class NowJob < Job
    def before(job)
      TaskDispatcher.new(@instance.task).pause
      super
    end

    def after(job)
      super
      TaskDispatcher.new(@instance.task).unpause
    end
  end
end
