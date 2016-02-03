class Entrant
  include Mongoid::Document
  include Mongoid::Timestamps

  store_in collection: "results"

  embeds_many :results,  as: :parent, class_name: "LegResult", after_add: :update_total  
  embeds_one :race, class_name: 'RaceRef'

  default_scope ->{order_by(:"event.o".desc)}
  field :bib, as: :bib, type: Integer
  field :secs, as: :secs, type: Float
  field :o, as: :overall, type: Placing
  field :gender, as: :gender, type: Placing
  field :group, as: :group, type: Placing

  def update_total(result)
    if result.secs
      self.secs = self.secs.nil? ? result.secs : + self.secs + result.secs
    end
  end

  def the_race
    race.race
  end
end
