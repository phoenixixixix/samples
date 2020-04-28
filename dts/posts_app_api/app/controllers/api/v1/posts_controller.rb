# frozen_string_literal: true

module Api
  module V1
    class PostsController < BaseController
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
    end
  end
end
