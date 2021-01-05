class ShiftsController < ApplicationController
  def index
    if current_user.admin?
       @shifts = Shift.where(designated_on: params[:date]).order("designated_on").order("kind")
       @day = params[:date]
    else
       @shifts = current_user.shifts.order(designated_on: "DESC").order("designated_on").order("kind").page(params[:page]).per(6)
    end
    @shift = Shift.new
    @count = 0
  end
  
  def update
    if select_shift_params.uniq.count == 1
      flash[:danger] = '項目を選択してください'
      redirect_back(fallback_location: root_path) 
    else
      select = []
      select_shift_params.map{|n|
        select << n
        select.delete("0")
      }
      
    @s = Shift.where(designated_on: Date.parse(params[:id]))
    if @s.present?
      @s.update_all(determine: 0)
    end
    
      select.each{|id|
        Shift.find(id).update(determine: 1)
      }
      flash[:success] = '登録されました'
      redirect_to action: 'index'
    end
  end
  
  def create
    date = shift_params
    params[:type].each do | a1,a2 |
      if a2 == "1"
        @get_kind = current_user.shifts.build(kind:a1, designated_on:date)
        if @get_kind.save!
          @flag = 0
        end
      end
    end
    if @flag == 0
      flash[:success] = '登録されました'
      redirect_to action: 'index'
    else
      flash[:danger] = '登録されませんでした'
      redirect_to action: 'index'
    end

  end
  
  def destroy
    @shift = Shift.find(params[:id])
    if @shift.present?
      @shift.destroy
    end
    flash[:success] = '削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def shift_params
    date = params.require(:shift)
    date.values[0]
  end
  
  def select_shift_params
    ids = params.require(:shift).permit(shift_ids: [])
    ids.values[0]
  end
end
