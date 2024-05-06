Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
	    # This initial version of the api doesnt support user's roles,
			# that's why users are not being listed.
      resources :users, only: %i[show create update]
    end
  end
end
