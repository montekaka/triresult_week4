class SwimResult < LegResult
	field :pace_100, as: :pace_100, type: Float

	def calc_ave
		if self.event && self.secs
			meters = self.event.meters
			self.pace_100 = meters.nil? ? nil : self.secs/(meters/100)
		end		
	end			
end