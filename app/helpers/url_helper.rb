module UrlHelper
  
  def grade(grade)
    grade.to_i
  end
  
  def readable_time(utc)
    # utc.strftime("%a %b #{utc.day.ordinalize}")
    utc.to_formatted_s(:long)
  end
    
end
