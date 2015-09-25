class User < ActiveRecord::Base
  attr_accessor :signin
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, :uniqueness => {:case_sensitive => false}

  def self.find_first_by_auth_conditions(warden_conditions)
     where(["lower(username) = :value OR lower(email)
       = :value", { :value => warden_conditions[:signin].downcase }]).first
  end
end
