class TopController < ApplicationController
  def home
    @job = Job.joins(:cities).order('created_at DESC').limit(5)
    @city = City.joins(:jobs).group(:name).order('count_all DESC').count.take(9)
    @industry = Industry.joins(:jobs).group(:name).order('count_all DESC').count.take(9)
  end
end
