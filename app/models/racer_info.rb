class RacerInfo
  include Mongoid::Document
  field :racer_id, as: :_id
  field :_id, default:->{racer_id}
  field :fn, as: :first_name, type: String
  field :ln, as: :last_name, type: String
  field :g, as: :gender, type: String
  field :yr, as: :birth_year, type: Integer
  field :res, as: :residence, type: Address

  embedded_in :parent, polymorphic: true
  validates :first_name, :last_name , presence: true
  validates :gender, inclusion: { in: ["M", "F"] } , presence: true
  validates :birth_year, numericality: {only_integer: true, less_than: Date.today.year} , presence: true

  ["city","state"].each do |action|
    define_method("#{action}") do 
      self.residence ? self.residence.send("#{action}") : nil
    end
    define_method("#{action}=") do |name|
      obj = self.residence ||= Address.new
      obj.send("#{action}=", name)
      self.residence=obj
    end
  end
end
