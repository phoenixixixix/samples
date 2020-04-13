# frozen_string_literal: true

module Api
  module V1
    class CommentsController < BaseController
      def index
        post = Post.find(params[:post_id])

        comments = post.comments.ordered_chronologically.includes(:user).page(params[:page]).per(params[:per_page])
        @comments_carrier = CollectionCarrier.new(
          comments,
          data_wrapper: ->(data) { data }
        )
      end
    end
  end
end
