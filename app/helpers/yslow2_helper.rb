module Yslow2Helper
  
  def json_to_hash(str,requested_key)
    str.each do |k,v|
      if k == requested_key
        if requested_key == "w"
          return number_to_human_size(v,2)
        else
          return v
        end
      end
    end
  end
  
end
