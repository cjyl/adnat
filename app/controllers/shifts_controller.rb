class ShiftsController < ApplicationController
  def new
    @shift = Shift.new
  end

  def create

  end

  private

  def shift_params
    params.require(:shift).permit(:start, :finish, :break_length)
  end

end
