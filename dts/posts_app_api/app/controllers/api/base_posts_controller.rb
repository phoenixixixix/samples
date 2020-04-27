# frozen_string_literal: true

module Api
  class BasePostsController < BaseController
    before_action :authenticate_user!, only: [:toggle_like]

    def index
      @posts_carrier = PostsCarrier.new(
        Post.ordered_chronologically,
        page: params[:page]
      )

      if stale?(@posts_carrier.page_scope, public: true) # rubocop:disable Style/GuardClause:
        response_json = Rails.cache.fetch(@posts_carrier.cache_key) do
          @posts_carrier.to_hash
        end
        render json: response_json
      end
    end

    def toggle_like
      post = Post.find(params[:id])

      TogglePostLikeService.new(post, @current_user).perform
    end
  end
end
