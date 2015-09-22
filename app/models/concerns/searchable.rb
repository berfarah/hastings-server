module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(parameter, attribute)
      self.where("#{attribute} LIKE ?", "%#{parameter}%")
    end
  end
end
