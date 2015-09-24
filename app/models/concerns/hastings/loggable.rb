module Hastings
  module Loggable
    extend ActiveSupport::Concern

    included do
      has_many :logs, as: :loggable
    end
  end
end
