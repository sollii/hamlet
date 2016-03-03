class HomesController < ApplicationController
  include GeoMathHelper

  def index
    @homes = Listing.all
    gon.rabl
  end

  def filtered_listings
    source, max_dist, max_time = filter_params.values_at(:source, :max_dist, :max_time)
    @filtered_listings = filter_matrix(source, Listing.all[0..70], @max_dist, @max_time)
  end


  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def filter_params
    params.require(:filter).permit(:source, :max_dist, :max_time)
  end
end
