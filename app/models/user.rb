class User < ApplicationRecord
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  has_many :questions
  has_many :answers
  has_many :authorizations

  def check_author(item)  
    item.user_id == id
  end

  def self.find_for_oauth(auth)

  end
end
