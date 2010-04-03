# | id           | int(11)  | NO   | PRI | NULL    | auto_increment |
# | url_id       | int(11)  | YES  |     | NULL    |                |
# | ip           | int(11)  | YES  |     | NULL    |                |
# | user_agent   | text     | YES  |     | NULL    |                |
# | w            | int(11)  | YES  |     | NULL    |                |
# | o            | int(11)  | YES  |     | NULL    |                |
# | r            | int(11)  | YES  |     | NULL    |                |
# | i            | text     | YES  |     | NULL    |                |
# | s            | int(11)  | YES  |     | NULL    |                |
# | lt           | int(11)  | YES  |     | NULL    |                |
# | ynumreq      | int(11)  | YES  |     | NULL    |                |
# | ycdn         | int(11)  | YES  |     | NULL    |                |
# | yexpires     | int(11)  | YES  |     | NULL    |                |
# | ycompress    | int(11)  | YES  |     | NULL    |                |
# | ycsstop      | int(11)  | YES  |     | NULL    |                |
# | yjsbottom    | int(11)  | YES  |     | NULL    |                |
# | yexpressions | int(11)  | YES  |     | NULL    |                |
# | yexternal    | int(11)  | YES  |     | NULL    |                |
# | ydns         | int(11)  | YES  |     | NULL    |                |
# | yminify      | int(11)  | YES  |     | NULL    |                |
# | yredirects   | int(11)  | YES  |     | NULL    |                |
# | ydupes       | int(11)  | YES  |     | NULL    |                |
# | yetags       | int(11)  | YES  |     | NULL    |                |
# | yxhr         | int(11)  | YES  |     | NULL    |                |
# | yxhrmethod   | int(11)  | YES  |     | NULL    |                |
# | ymindom      | int(11)  | YES  |     | NULL    |                |
# | yno404       | int(11)  | YES  |     | NULL    |                |
# | ymincookie   | int(11)  | YES  |     | NULL    |                |
# | ycookiefree  | int(11)  | YES  |     | NULL    |                |
# | ynofilter    | int(11)  | YES  |     | NULL    |                |
# | yimgnoscale  | int(11)  | YES  |     | NULL    |                |
# | yfavicon     | int(11)  | YES  |     | NULL    |                |
# | details      | text     | YES  |     | NULL    |                |
# | created_at   | datetime | YES  |     | NULL    |                |
# | updated_at   | datetime | YES  |     | NULL    |


class Yslow2 < ActiveRecord::Base
  belongs_to :url
  
  def self.readable_time(utc)
    # utc.strftime("%a %b #{utc.day.ordinalize}")
    utc.to_formatted_s(:long)
  end
  
end
