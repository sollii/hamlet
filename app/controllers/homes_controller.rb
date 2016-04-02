class HomesController < ApplicationController
  include GoogleApiHelper
  respond_to :html, :json, :xml

  def index
    @homes = initial_listings
    gon.rabl :template => "app/views/homes/index.json.rabl"
  end

  def filtered_listings
    source, max_dist, max_time = filter_params.values_at(:source, :max_dist, :max_time)
    filtered_listings = filter_listings_by_dist_from_source(source, initial_listings, max_dist.to_i, max_time.to_i)
    @homes = RablRails.render filtered_listings, 'index', view_path: 'app/views/homes', format: :json
    respond_with(@homes)
  end


  private

  # Never trust parameters from the scary internet, only allow the white list through.

  def filter_params
    params.require(:filter).permit(:source, :max_dist, :max_time)
  end

  def initial_listings
    Listing.all
  end
end
