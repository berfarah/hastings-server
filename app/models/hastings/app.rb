module Hastings
  class App < ActiveRecord::Base
    include Searchable
    include Loggable

    validates :name, presence: true
    validates :ip, presence: true, format: /\b(?:\d{1,3}\.){3}\d{1,3}\b/

    def to_param
      "#{id} #{name}".parameterize
    end
  end
end
