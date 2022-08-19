class User < ApplicationRecord
  has_many :posts
  has_many :commments
  has_many :likes
  scope :posts, -> { joins(:posts).where(posts: { user_id: id }) }

  def last_3_posts
    posts.order(created_at: :desc).limit(3)
  end
end
