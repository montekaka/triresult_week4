class Race
  include Mongoid::Document
  include Mongoid::Timestamps

  field :n, as: :name, type: String
  field :date, as: :date, type: Date
  field :loc, as: :location, type: Address

  scope :upcoming, ->{where(:date.gte => Date.current)}
  scope :past, ->{where(:date.lt => Date.current)}
  default_scope ->{order_by([:"entrant.secs".asc, :"entrant.bib".asc])}

  embeds_many :events,  as: :parent, class_name: "Event", order: [:order.asc]
  has_many :entrants, foreign_key: 'race._id', dependent: :delete

end
