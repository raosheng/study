class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#,:confirmable, :lockable
  #attr_accessible :loginname, :email, :password, :password_confirmation, :remember_me
  attr_accessor :login

  # 使用emal或者loginname登陆
    def self.find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(loginname) = :value OR lower(email) = :value", {:value => login.downcase}]).first
      else
        where(conditions).first
      end
    end
end
