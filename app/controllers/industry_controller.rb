class IndustryController < ApplicationController
  def list_industry
    @industry_list = Industry.industry_list
  end
end