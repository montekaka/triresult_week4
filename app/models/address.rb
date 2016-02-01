class Address
	attr_accessor :city, :state, :location

	def initialize(city, state, location)
		@city = city
		@state = state
		@location = location
	end	

	#creates a DB-form of the instance
	def mongoize
		return {:city=>@city,:state=>@state,:loc=>Point.mongoize(@location)}
	end	

	#creates an instance of the class from the DB-form of the data
	def self.demongoize object
		case object
		when Hash then Address.new(object[:city], object[:state], Point.demongoize(object[:loc]))
		else nil
		end
	end	

	#takes in all forms of the object and produces a DB-friendly form
	def self.mongoize object
		case object
		when Address then object.mongoize
		else object
		end
	end

	def self.evolve(object)
		case object
		when Address then object.mongoize
		else object
		end
	end	
end