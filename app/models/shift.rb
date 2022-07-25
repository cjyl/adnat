class Shift < ApplicationRecord
  belongs_to :organisation_user

  def shift_date
    # just prefer this style more
    start.to_s.split[0] if start
  end

  def start_time
    return unless start
    # h = start.to_s.split[1].split(':')[0]
    # m = start.to_s.split[1].split(':')[1]
    # "#{h}:#{m}"
    start.strftime("%H:%M")
  end

  def finish_time
    return unless finish
    # h = finish.to_s.split[1].split(':')[0]
    # m = finish.to_s.split[1].split(':')[1]
    # "#{h}:#{m}"
    finish.strftime("%H:%M")
  end

  def overnight
    finish.day > start.day
  end

  def hours_worked
    ((TimeDifference.between(start, finish).in_seconds - break_length * 60) / 3600).round(2)
  end

  def pay
    organisation_user.organisation.hourly_rate * hours_worked
  end

  # def penalty_pay
  #   if start.sunday? && finish.sunday?
  #     pay * 2
  #   elsif
  #     shift.start.sunday?
  #   end
  # end

end
