class Shift < ApplicationRecord
  belongs_to :organisation_user

  def shift_date
    # just prefer this style more
    start.to_s.split[0] if start
  end

  def start_time
    return unless start

    start.strftime("%H:%M")
  end

  def finish_time
    return unless finish

    finish.strftime("%H:%M")
  end

  def overnight
    finish.strftime("%D") > start.strftime("%D")
  end

  def hours_worked
    ((TimeDifference.between(start, finish).in_seconds - break_length * 60) / 3600).round(2)
  end

  def sunday_shift
    start.sunday? || finish.sunday?
  end

  def normal_pay
    (organisation_user.organisation.hourly_rate * hours_worked).round(2)
  end

  def penalty_pay
    rate = organisation_user.organisation.hourly_rate
    if start.sunday? && finish.sunday?
      normal_pay * 2 + (break_length / 60).round(2) * rate
    elsif start.sunday? && finish.monday?
      sunday_pay = TimeDifference.between(start, start.end_of_day).in_hours * rate
      normal_pay + sunday_pay
    elsif start.saturday? && finish.sunday?
      sunday_pay = TimeDifference.between(finish.beginning_of_day, start).in_hours * rate
      normal_pay + sunday_pay
    end
  end

  def final_pay
    if !sunday_shift
      normal_pay
    else
      penalty_pay
    end
  end
end
