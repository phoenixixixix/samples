# frozen_string_literal: true

module Api
  module V1
    class PostsController < BaseController
      before_action :authenticate_user, except: [:toggle_like]
      before_action :authenticate_user!, only: [:toggle_like]

      def index
        posts_scope = Post.ordered_chronologically.page(posts_page).per(params[:per_page])

        @posts_carrier = CollectionCarrier.new(
          posts_scope,
          data_wrapper: ->(data) { PostCarrier.wrap(data, @current_user) }
        )
      end

      def toggle_like
        post = Post.find(params[:id])

        TogglePostLikeService.new(post, @current_user).perform
      end

      private

      def posts_page
        params[:page] || 1
      end
    end
  end
end
