module Api
  module V1
    class PublicCategoriesController < ApplicationController
      before_action :authenticate_user!
    
      def index
        categories = Category.public_ones
        render json: CategoriesRepresenter.new(categories).as_json
      end
    
      def show
        render(
          json: category_representer,
          status: :ok
        )
      end
      
      private
  
      def set_category
        @category = Category.find(params[:id])
      end
  
      def category_representer
        @category_representer = CategoryRepresenter.new(@category).as_json
      end
    end  
  end
end
