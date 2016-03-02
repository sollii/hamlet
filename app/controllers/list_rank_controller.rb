class ListRankController < ApplicationController
    include GeoMathHelper

    def home
      @all_listings_in_berkeley = Listing.all.collect {|listing| listing.address}
    end

    def search
      @source = params[:source]
      @max_dist = (params[:max_dist].to_f * 1000).to_i
      @max_time = (params[:max_time].to_f * 60).to_i
      puts @max_time, @max_dist
      @filtered_listings = filter_matrix(@source, Listing.all.collect {|listing| listing.address}[0..70], @max_dist, @max_time)
    end

end
