class CityController < ApplicationController
  def list_city
    @cities_vietnam = City.cities(City::REGION_VN_ID)
    @cities_international = City.cities(City::REGION_INTERNATIONAL_ID)
  end
end