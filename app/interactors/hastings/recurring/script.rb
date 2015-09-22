module Hastings
  module Recurring
    # Recurring scripts
    class Script < Tracked
      def initialize(options = {})
        super
        @script = options.delete(:script)
      end

      def perform
        # app/interactors/actions/shell.rb captures output in real time
        Actions::Shell.run(@script) do |out, err|
          log :info,  out
          log :error, err
        end
      end
    end
  end
end
