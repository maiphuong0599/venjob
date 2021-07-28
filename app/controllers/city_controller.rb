class CityController < ApplicationController
  def list_city
    @city_vietnam = City.city_vietnam
    @city_inter = City.city_inter
  end
end