class Post < ApplicationRecord
  belongs_to :user

  def abbreviated_time_ago_in_words
    time_diff = Time.now - created_at
  
    case time_diff
    when 0..59
      "#{time_diff.to_i}s" # Seconds
    when 60..3599
      "#{(time_diff / 60).to_i}m" # Minutes
    when 3600..86_399
      "#{(time_diff / 3600).to_i}h" # Hours
    when 86_400..604_799
      "#{(time_diff / 86_400).to_i}d" # Days
    when 604_800..2_629_799
      "#{(time_diff / 604_800).to_i}w" # Weeks
    when 2_629_800..31_557_599
      "#{(time_diff / 2_629_800).to_i}mo" # Months
    else
      "#{(time_diff / 31_557_600).to_i}y" # Years
    end
  end
  
end
