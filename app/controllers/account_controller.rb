class AccountController < ApplicationController
  def reviews
    @reviews = Review.all
    @user = User.new
  end
end
