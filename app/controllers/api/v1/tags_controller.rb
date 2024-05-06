module Api
  module V1
    class TagsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_user
      before_action :set_tag, only: %i[show update destroy]
    
      def index
        tags = @user.tags_created
        render json: TagsRepresenter.new(tags).as_json
      end
    
      def show
        render(
          json: tag_representer,
          status: :ok
        )
      end
    
      def create
        @tag = created.build(tag_params)
    
        if @tag.save
          render json: tag_representer, status: :created
        else
          render json: {
            error: @tag.errors
          }, status: :unprocessable_entity
        end
      end
    
      def update
        if @tag.update(tag_params)
          render json: tag_representer
        else
          render json: {
            error: @tag.errors
          }, status: :unprocessable_entity
        end
      end
    
      def destroy
        @tag.update(active: false)
    
        head :no_content
      end
    
      def public
        render json: TagsRepresenter.new(created.public_ones).as_json
      end
    
      def private
        render json: TagsRepresenter.new(created.public_ones.invert_where).as_json
      end
    
      private
    
      def created
        @created ||= @user.tags_created
      end
    
      def tag_representer
        @tag_representer = TagRepresenter.new(@tag).as_json
      end
    
      def set_user
        @user = User.find(params[:user_id])
      end
    
      def set_tag
        @tag = created.find(params[:id])
      end
    
      def tag_params
        params.require(:tag).permit(
          :name,
          :description,
          :icon_url,
          :priority,
          :active,
          :is_public
        )
      end
    end
  end
end

