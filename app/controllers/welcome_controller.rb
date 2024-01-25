class WelcomeController < ApplicationController

  def index

  end

  def about
    @user = current_user
    @bacons = @user.bacons
    @caesars = @user.caesars
    @vigns = @user.vigns
    @xors = @user.xors
  end

end
