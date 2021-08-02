class JobsController < ApplicationController
  def search
    @search = Job.search do
      keywords(params[:search])
    end
  end
end
