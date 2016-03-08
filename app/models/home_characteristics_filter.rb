class HomeCharacteristicsFilter < Filter
  def filter(listings)
    min, max = self.bedrooms.split("-")
    listings.where{bedrooms >= min}.where{bedrooms <= max}
  end
end
