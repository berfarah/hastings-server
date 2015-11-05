class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks
  has_many :apps

  before_validation :check_whitelist
  validates :username, presence: true, uniqueness: true

  protected

    def check_whitelist
      whitelist = Rails.application.config.email_whitelist
      regex     = Rails.application.config.email_whitelist_regex
      return if whitelist.empty? || email =~ regex
      errors.add :email, "must be a valid email: #{whitelist.join('/')}"
    end
end
