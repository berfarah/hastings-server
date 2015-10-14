class Task
  class RecurringJob < Job
    include ::RecurringJobConcern
  end
end
