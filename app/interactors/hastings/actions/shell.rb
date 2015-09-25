require 'open3'

module Hastings
  module Actions
    # Ideas grabbed from
    # https://nickcharlton.net/posts/ruby-subprocesses-with-stdout-stderr-streams.html
    # Gets $stdout and $stderr in real-time from a shell process
    class Shell
      def initialize(script)
        @command = shell_type(script).freeze
      end

      def self.run(script, &block)
        new(script).shell(&block)
      end

      def shell(&block)
        Open3.popen3(@command) do |_stdin, stdout, stderr, thread|
          # read each stream from a new thread
          { out: stdout, err: stderr }.each do |key, stream|
            Thread.new do
              until (line = stream.gets).nil?
                # yield the block depending on the stream
                if key == :out
                  block.call line, nil, thread
                else
                  block.call nil, line, thread
                end
              end
            end
          end

          thread.join # don't exit until the external process is done
          exit_status = thread.value.exitstatus.to_i
          fail "Exited with #{exit_status} code" unless exit_status == 0
        end
      end

      private

        # Determinte how file is parsed based on extension
        def shell_type(script)
          case script
          when /\.rb$/        then 'ruby'
          when /\.(sh|bash)$/ then 'bash -l'
          else 'bash -l -c'
          end << " #{script}"
        end
    end
  end
end
