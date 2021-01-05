class ToppagesController < ApplicationController
  def index
    @days = Shift.select("designated_on").distinct.order(designated_on: "DESC").page(params[:page]).per(7)
    if current_user.admin?
      @shifts = Shift.all
    else
      @shifts = current_user.shifts.where(determine: true).order(designated_on: "DESC").order("kind").page(params[:page]).per(5)
    end
  end
end