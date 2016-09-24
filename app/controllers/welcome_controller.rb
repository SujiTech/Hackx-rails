class WelcomeController < ApplicationController
  def index
    @events = Event.paginate(:page => params[:page])
  end
end
