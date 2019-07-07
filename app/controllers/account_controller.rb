class AccountController < ApplicationController
  def reviews
    @reviews = Review.all
  end
end
