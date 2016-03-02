class HomesController < ApplicationController
  include GeoMathHelper

  def index
    @homes = Listing.all
    gon.rabl
  end

  def filteredListings

  end
end
