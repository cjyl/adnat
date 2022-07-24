class Shift < ApplicationRecord
  belongs_to :organisation_user
  def shift_date
    start.to_s.split[0] if start
  end

  def start_time
    return unless start

    h = start.to_s.split[1].split(':')[0]
    m = start.to_s.split[1].split(':')[1]
    "#{h}:#{m}"
  end

  def finish_time
    return unless finish

    h = finish.to_s.split[1].split(':')[0]
    m = finish.to_s.split[1].split(':')[1]
    "#{h}:#{m}"
  end

  def hours_worked
    (((finish - start) - break_length * 60) / 3600).round(2)
  end
end
