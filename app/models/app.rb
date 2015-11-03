class App < ActiveRecord::Base
  include Loggable

  validates :name, presence: true, uniqueness: true
  validates :ip, presence: true, format: /\b(?:\d{1,3}\.){3}\d{1,3}\b/

  def to_param
    "#{id} #{name}".parameterize
  end
end
