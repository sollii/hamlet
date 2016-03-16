class User < Sequel::Model
  # plugin :devise
  # plugin :timestamps, :update_on_create => true
  # # Include default devise modules. Others available are:
  # # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  one_to_many :filters, order: :precedence

  def filter_listings(listings)
    listings ||= Listing.all
    for filter in self.filters
      listings = filter.filter(listings)
    end
    return listings
  end
end
