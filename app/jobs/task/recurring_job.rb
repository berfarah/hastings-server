class Task < ActiveRecord::Base
  class RecurringJob < Job
    include ::RecurringJobConcern
  end
end
