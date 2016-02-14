module Api
	class RacesController < ApplicationController
		protect_from_forgery with: :null_session
		before_action :set_race, only: [:show, :edit, :update, :destroy]
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
				race=Race.find(@race)
				render json: race			
			end			
		end
		#post
		def create			
			name = race_params[:name]			
			if !request.accept || request.accept == "*/*"
				#render plain: :nothing, status: :ok
				if name
					render plain: name
				else
					render plain: :nothing, status: :ok
				end
			else
				race=Race.create(race_params)
				render json: race, status: :created		
			end
		end	

	  # PATCH/PUT /races/1
	  # PATCH/PUT /races/1.json
	  def update
	  	Rails.logger.debug("method=#{request.method}")
	  	@race.update(race_params)
	  	race = Race.find(@race)
			render json: race, status: :ok
	  end

	  # DELETE /races/1
	  # DELETE /races/1.json	  
	  def destroy
	  	@race.destroy
	  	render :nothing=>true, :status => :no_content
	  end

		private
	    def set_race
	      @race = Race.find(params[:id])
	    end		
	    # Never trust parameters from the scary internet, only allow the white list through.
	    def race_params
	      params.require(:race).permit(:id,:name, :date)
	    end		
	end
end