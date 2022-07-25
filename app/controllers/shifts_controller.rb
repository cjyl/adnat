class ShiftsController < ApplicationController
  before_action :find_organisation, only: %i[update destroy]

  def new
    @shift = Shift.new
  end

  def create
    year = params["shift"]["shift_date(1i)"].to_i
    month = params["shift"]["shift_date(2i)"].to_i
    day = params["shift"]["shift_date(3i)"].to_i
    start_h = params["shift"]["start_time(4i)"].to_i
    start_m = params["shift"]["start_time(5i)"].to_i
    finish_h = params["shift"]["finish_time(4i)"].to_i
    finish_m = params["shift"]["finish_time(5i)"].to_i
    break_length = params["shift"]["break_length"].to_i
    organisation_user_id = params["organisation_user_id"].to_i
    organisation = Organisation.find(params["organisation_id"].to_i)

    start = DateTime.new(year, month, day, start_h, start_m, 0)
    finish = DateTime.new(year, month, day, finish_h, finish_m, 0)

    if finish_h < start_h
      finish = finish.next_day(1)
    end

    shift = Shift.new(
      start: start,
      finish: finish,
      break_length: break_length,
      organisation_user_id: organisation_user_id
    )

    shift.save unless start == finish || start <= Time.now
    redirect_to organisation_path(organisation)
  end

  def update
    shift.update(shift_params)
    redirect_to organisation_path(@organisation)
  end

  private

  def shift_params
    params.require(:shift).permit(:start, :finish, :break_length)
  end

  def find_organisation
    @organisation = Organisation.find(params[:id])
  end
end
