class HomeCharacteristicsFilter < Filter
  def filter(listings)
    min_bedrooms, max_bedrooms = self.bedrooms.split("-")
    min_bathrooms, max_bathrooms = self.bathrooms.split("-")
    min_sq_footage = self.sq_footage
    listings.where{bedrooms >= min_bedrooms}.where{bedrooms <= max_bedrooms}.where{bathrooms >= min_bathrooms}.where{bathrooms <= max_bathrooms}.where{sq_footage >= min_sq_footage}
  end
end
