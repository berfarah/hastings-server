module Hastings
  module Searchable
    def self.included(base)
      base.include Elasticsearch::Model
      base.include Elasticsearch::Model::Callbacks
    end
  end
end
