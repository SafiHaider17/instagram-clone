class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom
  has_one_attached :image
end
