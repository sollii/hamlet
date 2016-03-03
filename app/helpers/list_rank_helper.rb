module ListRankHelper
  def get_listing_score(user, listing)
        distance_scale = get_distance_scale(user)
        distances = get_distances(listing.address.to_s, user.pois)


    end

    private def get_distances(listing_address, poi_prefs)

    end

    private def get_distance_scale(user)
    end
end
