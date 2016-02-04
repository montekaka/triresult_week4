class LegResult
  include Mongoid::Document

  field :secs, as: :secs, type: Float
  embedded_in :entrant
  
  embeds_one :event, as: :parent
  validates :event,  presence: true
  after_initialize :calc_ave

  def calc_ave
	end
	
	# after_initialize do |doc|
	# 	doc.calc_ave
	# end
	def secs= value
		self[:secs] = value
		self.calc_ave
	end
end
