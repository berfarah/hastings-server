class Task
  class Runtime
    attr_reader :sample

    def initialize(task)
      @sample = task.instances.last(2).map(&:duration).compact
    end

    def average
      unless_empty { sample.mean.ceil }
    end

    def standard_deviation
      unless_empty { sample.standard_deviation.round(2) }
    end

    def as_json
      { average: average, standard_deviation: standard_deviation }
    end

    private

      def unless_empty(&block)
        sample.empty? ? nil : block.call
      end
  end
end
