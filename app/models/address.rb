class Address < Sequel::Model
  one_to_many :place

  def to_s
    "#{self.street}, #{self.city}, #{self.state} #{self.zip}, USA"
  end

  def self.unique?(params)
    Address.where(params).count == 0
  end
end
