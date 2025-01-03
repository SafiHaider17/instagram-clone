class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :body
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :body, presence: true

  def self.search_by_body(query)
    joins(:rich_text_body).where("action_text_rich_texts.body ILIKE ?", "%#{query}%")
  end
end
