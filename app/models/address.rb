class Address < ActiveRecord::Base
  has_many :places

  def to_s
    "#{self.street}, #{self.city}, #{self.state} #{self.zip}, USA"
  end
end
