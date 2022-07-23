class ShiftsController < ApplicationController
  def new
    @shift = Shift.new
  end

  def create
    year = params["shift"]["shift_date(1i)"].to_i
    month = params["shift"]["shift_date(2i)"].to_i
    day = params["shift"]["shift_date(3i)"].to_i
    start_time = params["shift"]["start_time"].to_i
    finish_time = params["shift"]["finish_time"].to_i
    break_length = params["shift"]["break_length"].to_i
    organisation_user_id = params["organisation_user_id"].to_i
    organisation = Organisation.find(params["organisation_id"].to_i)

    start = DateTime.new(year, month, day, start_time, 0, 0)
    finish = DateTime.new(year, month, day, finish_time, 0, 0)
    shift = Shift.new(
      start: start,
      finish: finish,
      break_length: break_length,
      organisation_user_id: organisation_user_id
    )
    shift.save unless start >= finish || start < Time.now
    redirect_to organisation_path(organisation), status: :unprocessable_entity
  end

  def show
    raise
  end

  private

  def shift_params
    params.require(:shift).permit(:start, :finish, :break_length)
  end
end
