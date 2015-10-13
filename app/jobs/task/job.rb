class Task
  class Job
    def initialize(options = {})
      @task    = options.delete(:task).id
      @script  = options.delete(:script).path
      @options = options
      super()
    end

    def before(job)
      @instance = Task.find(@task).instances.create(job_id: job.id)
    end

    def perform
      # app/interactors/actions/shell.rb captures output in real time
      ShellScript.run(@script) do |out, err|
        log :info,  out
        log :error, err
      end
    end

    def error(_job, e)
      log :fatal, [e.message, e.backtrace].flatten.join("\n")
      @instance.failed = true
    end

    def after(_job)
      @instance.finished_at = Time.zone.now
      @instance.job_id = nil
      @instance.save!
    end

    def exist?
      ::Delayed::Job
        .where("(handler LIKE ?) OR (handler LIKE ?)",
               "%!ruby/object:#{self.class.name} %",
               "% !ruby/object:#{self.class.name}\n%")
        .where(queue: @options[:queue])
        .exists?
    end

    private

      def log(severity, message)
        return if message.nil? || message.empty?
        @instance.logs.create(severity: severity, message: message.chomp)
      end
  end
end
