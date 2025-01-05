class PagesController < ApplicationController
  def home
    flash[:notice] = "Welcome to the home page!"
  end
end
