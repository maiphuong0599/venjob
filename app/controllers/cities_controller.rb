class CitiesController < ApplicationController
  def show
    @cities_vietnam = City.cities_by_region(City::REGION_VN_ID)
    @cities_international = City.cities_by_region(City::REGION_INTERNATIONAL_ID)
  end
end