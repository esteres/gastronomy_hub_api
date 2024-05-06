module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: %i[show update]

      def create
        @user = User.new(user_params)
        if @user.save
          render json: user_representer, status: :created
        else
          render json:  {
            error: @user.errors 
          }, status: :unprocessable_entity
        end
      end

      def show
        render(
          json: user_representer,
          status: :ok
        )
      end

      def update
        if @user.update(user_params)
          render json: user_representer, status: :ok
        else
          render json:  {
            error: @user.errors 
          }, status: :unprocessable_entity
        end
      end

      private

      def user_representer
        UserRepresenter.new(@user).as_json
      end

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
