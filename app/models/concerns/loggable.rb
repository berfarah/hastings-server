module Loggable
  extend ActiveSupport::Concern

  included do
    has_many :logs, as: :loggable, dependent: :destroy
  end
end
