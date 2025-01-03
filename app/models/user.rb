class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :comments
  has_many :likes

  has_many :messages
  has_many :chatrooms
  has_one_attached :avatar

end
  # def avatar_thumbnail
  #   if avatar.attached?
  #     avatar.variant(resize: '150x150!').processed
  #   else
  #     "default_profile.jpg"
  #   end
  # end



