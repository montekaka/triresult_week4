module Api
	class ResultsController < ApplicationController
		protect_from_forgery with: :null_session
		#before_action :set_result, only: [:show, :update]		
		def index
			if !request.accept || request.accept == "*/*"
				render plain: "/api/races/#{params[:race_id]}/results"
			else
			end
		end
		def show
			if !request.accept || request.accept == "*/*"
				render plain: "/api/races/#{params[:race_id]}/results/#{params[:id]}"
			else
				set_result
				#render action: :show
				render :partial=>"result", :object=>@result
			end			
		end

	  # PATCH/PUT /races/1
	  # PATCH/PUT /races/1.json
	  def update
	  	set_result	  	
	  	entrant=@result
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
	  		entrant.save
	  	end

	  	# fresh_when(@result)
	  	# @result.update(result_params)
	  	# result = Race.find(@result)
	  	# render json: result, status: :ok
	  end

		private
		def set_result
			@result = Race.find(params[:race_id]).entrants.where(:id=>params[:id]).first
		end	
    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:id,:swim, :t1, :bike, :t2,:run)
    end					
	end	
end