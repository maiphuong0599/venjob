class TopController < ApplicationController
  def home
    @job = Job.join_order
    @city = City.join_group
    @industry = Industry.join_group
  end
end
