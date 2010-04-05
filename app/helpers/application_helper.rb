# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def fastest_sites
    yslow_grades = Yslow2.find(:all, :select => 'DISTINCT url_id', :limit => 10)
    top_ten_fastest = yslow_grades.inject("<table><thead><th>Rank</th><th>Url</th><th>Yslow</th></thead>") {|table, td| table + "<tr><td class='center'>#{td.url.country_rank}</td><td>#{td.url.url_name}</td><td class='center'>#{td.url.yslow2s.last.o}</td></tr>"}
    top_ten_fastest << "</table>"   
  end

  def slowest_sites
    yslow_grades = Yslow2.find(:all, :select => 'DISTINCT url_id', :limit => 10, :order => "o ASC")
    top_ten_slowest = yslow_grades.inject("<table><thead><th>Rank</th><th>Url</th><th>Yslow</th></thead>") {|table, td| table + "<tr><td class='center'>#{td.url.country_rank}</td><td>#{td.url.url_name}</td><td class='center'>#{td.url.yslow2s.last.o}</td></tr>"}
    top_ten_slowest << "</table>"   
  end

end
