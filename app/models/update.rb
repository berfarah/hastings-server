class Update < ActiveRecord::Base
  belongs_to :user
  belongs_to :updatable, polymorphic: true
end
