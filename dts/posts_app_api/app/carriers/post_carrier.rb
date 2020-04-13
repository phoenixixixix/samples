# frozen_string_literal: true

class PostCarrier < SimpleDelegator
  def initialize(post, user, liked_posts: nil)
    super(post)
    @user = user
    @liked_posts = liked_posts
  end

  def self.wrap(posts, user)
    liked_posts = user ? user.likes.where(post: posts.pluck(:id)).pluck(:post_id) : nil
    posts.map { |post| new(post, user, liked_posts: liked_posts) }
  end

  def liked_by_me?
    return false unless @user
    return post.likes.where(user: @user).exists? unless @liked_posts

    @liked_posts.include?(post.id)
  end

  def likes_count
    super.to_i
  end

  private

  def post
    __getobj__
  end
end
