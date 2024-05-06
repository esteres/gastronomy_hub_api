module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :authenticate_user!
      before_action :authorize_user!
      before_action :set_user
      before_action :set_category, only: %i[show update destroy]
    
      def index
        categories = @user.categories_created
        render json: CategoriesRepresenter.new(categories).as_json
      end
    
      def show
        render(
          json: category_representer,
          status: :ok
        )
      end
    
      def create
        @category = created.build(category_params)
    
        if @category.save
          render json: category_representer, status: :created
        else
          render json: {
            error: @category.errors
          }, status: :unprocessable_entity
        end
      end
    
      def update
        if @category.update(category_params)
          render json: category_representer
        else
          render json: {
            error: @category.errors
          }, status: :unprocessable_entity
        end
      end
    
      def destroy
        @category.update(active: false)
    
        head :no_content
      end
    
      def public
        render json: CategoriesRepresenter.new(created.public_ones).as_json
      end
    
      def private
        render json: CategoriesRepresenter.new(created.public_ones.invert_where).as_json
      end
    
      private
    
      def created
        @created ||= @user.categories_created
      end
    
      def category_representer
        @category_representer = CategoryRepresenter.new(@category).as_json
      end
    
      def set_user
        @user = User.find(params[:user_id])
      end
    
      def set_category
        @category = created.find(params[:id])
      end
    
      def category_params
        params.require(:category).permit(
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

