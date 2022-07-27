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

  def break_hours
    break_length.fdiv(60).round(2)
  end

  def hours_worked
    (TimeDifference.between(start, finish).in_seconds / 3600).round(2)
  end

  def break_pay(length, rate)
    length * rate
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
      normal_pay * 2 - break_pay(break_hours, rate * 2)
    elsif start.sunday? && finish.monday?
      sunday_pay = TimeDifference.between(start, start.end_of_day).in_minutes.fdiv(60) * rate
      net_pay = normal_pay + sunday_pay
      # Subtract break money
      monday_length = TimeDifference.between(finish.beginning_of_day, finish).in_minutes.fdiv(60)
      if monday_length >= break_hours
        break_pay = break_pay(break_hours, rate)
      else
        sunday_break_hours = break_hours - monday_length
        break_pay = break_pay(monday_length, rate) + break_pay(sunday_break_hours, rate * 2)
      end
      (net_pay - break_pay).round(2)

    elsif start.saturday? && finish.sunday?
      sunday_length = TimeDifference.between(finish.beginning_of_day, finish).in_minutes.fdiv(60)
      net_pay = sunday_length * rate + normal_pay
      if sunday_length >= break_hours
        break_pay = break_pay(break_hours, rate * 2)
      else
        saturday_break_hours = break_hours - sunday_length
        break_pay = break_pay(sunday_length, rate * 2) + break_pay(saturday_break_hours, rate)
      end
      (net_pay - break_pay).round(2)
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
