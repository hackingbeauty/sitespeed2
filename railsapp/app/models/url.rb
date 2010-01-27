class Url < ActiveRecord::Base
  has_many :yslows
  has_many :yslow2s
  has_many :page_speeds
end
