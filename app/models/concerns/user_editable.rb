module UserEditable
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    has_many :updates, as: :updatable, dependent: :destroy
  end
end
