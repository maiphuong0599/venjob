class IndustriesController < ApplicationController
  def show
    @industry_list = Industry.industry_list
  end
end