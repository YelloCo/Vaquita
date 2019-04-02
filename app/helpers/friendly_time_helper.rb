module FriendlyTimeHelper
  def time_difference(minutes)
    return "#{minutes}m" if minutes < 60

    if minutes < 2880
      hours = (minutes / 60.0).round
      "#{hours}h"
    else
      days = ((minutes / 60.0) / 24).round
      "#{days}d"
    end
  end
end
