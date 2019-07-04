class HomeController < ApplicationController
  def index
    @reviews = Review.most_recent
  end
end
