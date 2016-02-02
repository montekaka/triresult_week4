class Event
  include Mongoid::Document
  
  field :o, as: :order, type: Integer
  field :n, as: :name, type: String
  field :d, as: :distance, type: Float
  field :u, as: :units, type: String
  validates :order, :name , presence: true
  
  embedded_in :parent, polymorphic: true, touch: true

  def meters
  	unit = self.u
  	distance = self.d  	
  	
  	# if unit == "meters"
  	# 	d = distance
  	# elsif unit == 'kilometers'
  	# 	d = 1000*distance
  	# elsif unit == 'yards'
  	# 	d = 0.9144*distance
  	# elsif unit == 'miles'
  	# 	d = 1609.34*distance
  	# end
  			
  	case unit
  	when "meters" then d = distance
  	when 'kilometers' then d = 1000*distance
  	when 'yards' then d = 0.9144*distance
  	when 'miles' then d = 1609.34*distance
  	else p "#{distance} #{unit}"
  	end
  	return d
  end

  def miles
  	unit = self.u
  	distance = self.d
  	
  	case unit
  	when "meters" then d = 0.000621371*distance
  	when 'kilometers' then d = 0.621371*distance
  	when 'yards' then d = 0.000568182*distance
  	when 'miles' then d = distance  
  	else p "#{distance} #{unit}"	
  	end
  	return d	
  end  
end
