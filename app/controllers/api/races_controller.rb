module Api
	class RacesController < ApplicationController
		protect_from_forgery with: :null_session
		def index
			if !request.accept || request.accept == "*/*"
				render plain: "/api/races"
			else

			end
		end
		def show
			if !request.accept || request.accept == "*/*"
				render plain: "/api/races/#{params[:id]}"
			else
				
			end			
		end
		#post
		def create			
			#protect_from_forgery with: :null_session
			if !request.accept || request.accept == "*/*"
				render plain: :nothing, status: :ok
			else
			end
		end
	end
end