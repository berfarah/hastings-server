module Hastings
  module LogsHelper
    def of_instance
      id = params[:instance_id]
      return unless id
      ' of '.html_safe <<
        link_to("Instance #{id}", instance_path(id))
    end

    def severity_class(severity)
      { info: '',
        warn: 'text-warning',
        error: 'text-danger',
        fatal: 'text-danger danger' }[severity.to_sym]
    end

    def time_to_complete(duration)
      return unless duration
      'Took ' << duration.human_time << ' to complete'
    end

    def time_format(time)
      return unless time
      I18n.l time.localtime, format: :human
    end

    def time_default(time)
      I18n.l time.localtime, format: :default
    end
  end
end
