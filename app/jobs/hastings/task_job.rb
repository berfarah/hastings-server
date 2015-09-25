module Hastings
  class TaskJob
    include TrackableJob
    include ExistingJob

    def initialize(options = {})
      super
      @script  = options.delete(:script)
      @options = options
    end

    def perform
      # app/interactors/actions/shell.rb captures output in real time
      Actions::Shell.run(@script) do |out, err|
        log :info,  out
        log :error, err
      end
    end

    def success
      @instance.task.run_now_done
    end

    def failure
      @instance.task.run_now_done
    end

    def self.run(opts)
      opts.delete(:run_at)
      opts.delete(:run_every)
      instance = new(opts)
      return false if instance.exist?
      ::Delayed::Job.enqueue instance, opts
    end
  end
end
