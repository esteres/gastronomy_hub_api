Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#create'

	    # This initial version of the api doesnt support user's roles,
			# that's why users are not being listed.
      resources :users, only: %i[create show update] do
        resources :categories do
          collection do
            get 'private'
            get 'public'
          end
        end
        resources :tags do
          collection do
            get 'private'
            get 'public'
          end
        end
      end

      resources :public_categories, only: %i[index show]
      resources :public_tags, only: %i[index show]
    end
  end
end

