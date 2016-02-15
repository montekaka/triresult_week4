module Api
	class RacersController < ApplicationController
		protect_from_forgery with: :null_session
		def index
			if !request.accept || request.accept == "*/*"
				render plain: "/api/racers"
			else

			end
		end
		def show
			if !request.accept || request.accept == "*/*"
				render plain: "/api/racers/#{params[:id]}"
			else
				
			end			
		end
	end
end