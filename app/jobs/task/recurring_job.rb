class Task
  class RecurringJob < Job
    include ::RecurringJob

    def before(job)
      super
    end
  end
end
