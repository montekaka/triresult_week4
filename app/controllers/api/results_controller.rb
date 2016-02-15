module Api
	class ResultsController < ApplicationController
		protect_from_forgery with: :null_session
		#before_action :set_result, only: [:show, :update]		
		def index
			if !request.accept || request.accept == "*/*"
				render plain: "/api/races/#{params[:race_id]}/results"
			else
				@race=Race.find(params[:race_id])
				@entrants=@race.entrants
			end
		end
		def show
			if !request.accept || request.accept == "*/*"
				render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
			else
				@result = Race.find(params[:race_id]).entrants.where(id: params[:id]).first
				render :partial=>"result", :object=>@result
			end			
		end

	  # PATCH/PUT /races/1
	  # PATCH/PUT /races/1.json
	  def update
	  	#set_value
	  	entrant = Race.find(params[:race_id]).entrants.where(id: params[:id]).first	  						
	  	result=params[:result]
	  	if result 
	  		if result[:swim]
	  			entrant.swim=entrant.race.race.swim
	  			entrant.swim_secs = result[:swim].to_f
	  		end
	  		if result[:t1]
	  			entrant.t1=entrant.race.race.t1
	  			entrant.t1_secs = result[:t1].to_f
	  		end
	  		if result[:bike]
	  			entrant.bike = entrant.race.race.bike
	  			entrant.bike_secs = result[:bike].to_f
	  		end
	  		if result[:t2]
	  			entrant.t2 = entrant.race.race.t2
	  			entrant.t2_secs = result[:t2].to_f
	  		end
	  		if result[:run]
	  			entrant.run = entrant.race.race.run
	  			entrant.run_secs = result[:run].to_f
	  		end
	  	end	
	  	entrant.save 
	  	render json: entrant, status: :ok 	
	  end

		private
		def set_value
			@result = Race.find(params[:race_id]).entrants.where(:id=>params[:id]).first
		end	
    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:id,:swim, :t1, :bike, :t2,:run)
    end					
	end	
end