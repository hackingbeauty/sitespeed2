# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def fastest_sites
    # yslow_grades = Yslow2.find(:all, :order => 'o DESC', :select => 'DISTINCT url_id',  :limit => 10)
    yslow_grades = Yslow2.find_by_sql(["SELECT o, url_id FROM yslow2s ORDER BY o desc LIMIT 10"])
    top_ten_fastest = yslow_grades.inject("<table><thead><th>Rank</th><th>Url</th><th>Yslow</th></thead>") {|table, td| table + "<tr><td class='center'>#{td.url.country_rank}</td><td>#{td.url.url_name}</td><td class='center'>#{link_to td.url.yslow2s.last.o, td.url}</td></tr>"}
    top_ten_fastest << "</table>"   
  end

  def slowest_sites
    # yslow_grades = Yslow2.find(:all, :order => 'o ASC', :select => 'DISTINCT url_id', :limit => 10)
    yslow_grades = Yslow2.find_by_sql(["SELECT o, url_id FROM yslow2s ORDER BY o asc LIMIT 10"])
    top_ten_slowest = yslow_grades.inject("<table><thead><th>Rank</th><th>Url</th><th>Yslow</th></thead>") {|table, td| table + "<tr><td class='center'>#{td.url.country_rank}</td><td>#{td.url.url_name}</td><td class='center'>#{link_to td.url.yslow2s.last.o, td.url}</td></tr>"}
    top_ten_slowest << "</table>"   
  end
  
  def convert_to_kilobytes(bytes)
    "#{(bytes.to_f)/1000} kilobytes"
  end
  
  def convert_to_seconds(milliseconds)
    "#{(milliseconds).to_f/1000}s"
  end


end
