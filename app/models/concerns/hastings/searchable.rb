module Hastings
  module Searchable
    extend ActiveSupport::Concern

    module ClassMethods

      def searchable_attributes(*attrs)
        @searchable_attributes ||= attrs.empty? ? column_names : attrs
      end

      def pattern_search
        @pattern_search ||= PatternSearch.new(*searchable_attributes)
      end

      def search(parameter, *attribute)
        param = String(parameter).dup
        pattern_search.extract!(param).inject(all) do |a, (k, v)|
          a.where("#{k} LIKE ?", v)
        end
        # searchable_attributes.inject(self) { |a, e| a.where("#{e} LIKE ?", "%#{parameter}%") }
      end
    end
  end
end
