class ::String
  def rm(str_or_rgx)
    gsub(str_or_rgx, '')
  end

  def rm!(str_or_rgx)
    gsub!(str_or_rgx, '')
    self
  end

  def rms!(*str_or_rgxs)
    str_or_rgxs.each do |str_or_rgx|
      rm!(str_or_rgx)
    end
    self
  end

  def split_by_sp
    split(/ +/)
  end

  def parentheses
    "(#{self})"
  end

  def braces
    "{#{self}}"
  end

  # FIX:
  def equalize!
    rms!(/\A +/, / +\z/)
    if self =~ /\A\(/ && self =~ /\)\z/
      rms!(/\A\(/, /\)\z/)
      rms!(/\A +/, / +\z/)
    else
      self
    end
  end
end

class ::Array
  def join_by_sp
    join(' ')
  end
end
