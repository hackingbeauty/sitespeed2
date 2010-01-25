module BeaconHelper

  def url_id(url)
    u = Url.find_by_url(url)
    
    if u == nil
      u = Url.new
      u.url = url
      u.save  
    end
    
    return u.id
  end

end
