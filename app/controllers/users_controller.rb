class UsersController < ApplicationController
  before_action :admin_user?
  def index
    @users = User.all
  end
 
  def show
    @user = User.find(params[:id])
    @shifts = @user.shifts.order(designated_on: "DESC").order("designated_on").order("kind").page(params[:page]).per(6)
  end
end