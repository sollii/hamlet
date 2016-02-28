class Address < ActiveRecord::Base
  has_many :places

  def to_s
    return "#{self.street} #{self.city} #{self.state} #{self.zip}"
  end
end
