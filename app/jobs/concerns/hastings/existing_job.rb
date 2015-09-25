module Hastings
  module ExistingJob
    def exist?
      find =
        ::Delayed::Job
          .where("(handler LIKE ?) OR (handler LIKE ?)",
                 "%!ruby/object:#{self.class.name} %",
                 "% !ruby/object:#{self.class.name}\n%")
          .where(queue: @options[:queue])
      p self.class.name
      p find.length > 0

      find.length > 0
    end
  end
end
