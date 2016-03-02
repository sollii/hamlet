class HomesController < ApplicationController
  def index
    @homes = Listing.all
    gon.rabl
  end
end
