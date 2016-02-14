module Api
	class RacesController < ApplicationController
		protect_from_forgery with: :null_session
		def index
			offset = params[:offset]
			limit = params[:limit]
			query_array = []
			if offset
				offset_Str = "offset=[#{offset}]"
				query_array.push(offset_Str)
			end
			if limit
				limit_Str = "limit=[#{limit}]"
				query_array.push(limit_Str)
			end			
			query_string = ''
			query_array.each do |q|
				if query_string == ''
					query_string = "#{q}"
				else
					query_string = "#{query_string}, #{q}"
				end
			end
			if !request.accept || request.accept == "*/*"
				if query_array 
					render plain: "/api/races, #{query_string}"
				else
					render plain: "/api/races"
				end
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
			name = races_params[:name]			
			if !request.accept || request.accept == "*/*"
				#render plain: :nothing, status: :ok
				if name
					render plain: name
				else
					render plain: :nothing, status: :ok
				end
			else				
			end
		end		
		private
	    # Never trust parameters from the scary internet, only allow the white list through.
	    def races_params
	      params.require(:race).permit(:id,:name)
	    end		
	end
end