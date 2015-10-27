class Task < ActiveRecord::Base
  class Statistics
    attr_reader :task

    def initialize(task)
      @task = task
    end

    delegate :id, to: :task

    def runtime
      @runtime ||= Runtime.new(@task)
    end

    def last_run
      try_last(:created_at)
    end

    def failed?
      try_last(:failed)
    end

    def as_json(object = {})
      {
        id: id,
        task_id: id,
        last_run: last_run,
        failed: failed?,
        runtime_average: runtime.average,
        runtime_standard_deviation: runtime.standard_deviation
      }
    end

    private

      def try_last(symbol)
        @task.instances.last.try(symbol)
      end
  end
end
