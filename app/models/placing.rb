class Placing
	attr_accessor :name, :place

	def initialize(name, place)
		@name = name
		@place = place
	end	

	#creates an instance of the class from the DB-form of the data
	def self.demongoize object
		case object
		when Hash then Point.new(object[:name], object[:place])
		else nil
		end
	end

	def self.demongoize object
		case object
		when Hash then Placing.new(object[:name], object[:place])
		else nil
		end
	end

	def self.mongoize object
		case object
		when Placing then object.mongoize
		#when Hash then Placing.new(object[:name], object[:place])
		else object
		end
	end

	def mongoize
		return {:name=>@name, :place=>@place}
	end

	def self.evolve(object)
		case object
		when Placing then object.mongoize
		else object
		end
	end			
end