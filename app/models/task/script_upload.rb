class Task
  # Module that contains all the logic pertaining to the script
  module ScriptUpload
    extend ActiveSupport::Concern

    included do
      mount_uploader :script, ScriptUploader
      validate :script_validation
    end

    protected

      def script_validation
        return if !script_changed? || command_line_validation(script)
        errors.add(:script, "does not pass validation")
      end

      def command_line_validation(script)
        case script.filename
        when /\.rb$/ then system("ruby -wc #{script.path}")
        when /\.sh$/ then system("bash -n #{script.path}")
        else false
        end
      end
  end
end
