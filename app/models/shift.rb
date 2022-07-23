class Shift < ApplicationRecord
  belongs_to :organisation_user
  def shift_date
    start.to_s.split[0] if start
  end

  def start_time
    start.to_s.split[1].split(':')[0].to_i if start
  end

  def finish_time
    finish.to_s.split[1].split(':')[0].to_i if finish
  end

  def hours_worked
    (((finish - start) - break_length * 60) / 3600).round(2)
  end
end
