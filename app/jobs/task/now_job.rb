class Task
  class NowJob < Job
    def before(job)
      super
      TaskDispatcher.new(@instance.task).pause
    end

    def after(job)
      super
      TaskDispatcher.new(@instance.task).unpause
    end
  end
end
