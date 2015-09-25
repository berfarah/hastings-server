module Hastings
  class PatternSearch
    # This regex allows the following search formats:
    #   key:value
    #   key:'value with spaces'
    #   key:`value with spaces`
    #   key:"value with spaces"
    PATTERN = /(?<k>[^ ]+):(?<v>(?:(?<q>[`"']).+?\k<q>)|[^ ]+)/.freeze

    attr_reader :allowed, :extract

    def initialize(*allowed)
      @allowed = allowed.freeze
      @extract = {}
    end

    def extract!(str)
      parse!(str)
      extract
    end

    # Returns an object and mutates the string to exclude valid matches
    #
    # @param [String] to be parsed
    # @return [String] String with values parsed out
    def parse!(str)
      str.gsub!(PATTERN) do |match|
        m = Regexp.last_match
        next match unless allowed.include? m["k"]

        Rails.logger.info "what"

        remove_quotes! m["v"]
        extract[m["k"]] = m["v"]

        nil # Since it's a valid entry, we remove it via gsub
      end
    end

    private

      def remove_quotes!(str)
        str.sub!(/^(["'])(.+?)\1$/, '\2')
      end
  end
end
