class CityController < ApplicationController
  def list_city
    @cities_vietnam = City.cities_by_region(City::REGION_VN_ID)
    @cities_international = City.cities_by_region(City::REGION_INTERNATIONAL_ID)
  end

  def show
    @city = City.find(params[:slug])
    @jobs = @city.jobs.order(created_at: :desc).page(params[:page]).per(20)
  end
end