# Additional ways to parse time
class Integer
  def human_time
    to_f.human_time
  end
end

class Float
  def human_time
    hours, rest = divmod(3600)
    minutes, seconds = rest.divmod(60)
    { hours: hours,
      minutes: minutes,
      seconds: seconds.round_human }.map do |k, v|
      k = k[0..-2] if  v == 1
      "#{v} #{k}" if v > 0
    end.compact.join(', ').sub(/,([^,]+)$/, ' and\1')
  end

  def round_human
    to_i == self ? to_i : self.round(2)
  end
end
