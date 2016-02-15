module Api
	class RacesController < ApplicationController
		protect_from_forgery with: :null_session
		#before_action :set_race, only: [:show, :edit, :update, :destroy]
		rescue_from ActiveRecord::RecordInvalid, with: [:update, :show]
		rescue_from ActionView::MissingTemplate, with: :show
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
				#render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
			else
				set_race
				render action: :show
			end		
		end
		#post
		def create
			Rails.logger.debug("Accept:#{request.accept}")
			name = race_params[:name]
			if !request.accept || request.accept == "*/*"				
				if params && params[:race] && params[:race][:name]
					render plain: "#{params[:race][:name]}", status: :ok
				else
					render plain: :nothing, status: :ok
				end
			else
				race=Race.create(race_params)			
				if race.save	
					render plain: "#{params[:race][:name]}", status: :created
				end
			end
		end	

	  # PATCH/PUT /races/1
	  # PATCH/PUT /races/1.json
	  def update
	  	set_race
	  	Rails.logger.debug("method=#{request.method}")
	  	@race.update(race_params)
	  	race = Race.find(@race)
			render json: race, status: :ok
	  end

	  # DELETE /races/1
	  # DELETE /races/1.json	  
	  def destroy
	  	set_race
	  	@race.destroy
	  	render :nothing=>true, :status => :no_content
	  end

		rescue_from Mongoid::Errors::DocumentNotFound do |exception|
			# @error_msg = plain: "woops: cannot find race[#{params[:id]}]", status: :not_found			
			# render @error_msg
			if !request.accept || request.accept == "*/*"
				render plain: "woops: cannot find race[#{params[:id]}]", status: :not_found
			elsif request.accept == 'application/xml'
				render :status=>:not_found,
							 :template=>"api/error_msg_xml",
							 :locals=>{ :msg=>"woops: cannot find race[#{params[:id]}]"}
			elsif request.accept == 'application/json'
				render :status=>:not_found,
							 :template=>"api/error_msg_json",
							 :locals=>{ :msg=>"woops: cannot find race[#{params[:id]}]"}				
			end			
		end
		rescue_from ActionView::MissingTemplate do |exception|
			render plain: "woops: we do not support that content-type[#{request.accept}]", status: 415
		end
		private
	    def set_race
	      @race = Race.find(params[:id])
	    end		
	    # Never trust parameters from the scary internet, only allow the white list through.
	    def race_params
	      #params.require(:race).permit(:id,:name, :date)
	      params.require(:race).permit(:name, :date)
	    end		
	end
end