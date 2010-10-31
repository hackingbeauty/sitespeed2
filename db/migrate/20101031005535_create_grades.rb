class CreateGrades < ActiveRecord::Migration
  def self.up
    create_table :grades, :primary_key => :id do |t|
      t.string :id
      t.string :yslow2_id
      t.string :ynumreq
      t.string :ycdn
      t.string :yexpires
      t.string :ycompress
      t.string :ycsstop
      t.string :yjsbottom
      t.string :yexpressions
      t.string :yexternal
      t.string :ydns
      t.string :yminify
      t.string :yredirects
      t.string :ydupes
      t.string :yetags
      t.string :yxhr
      t.string :yxhrmethod
      t.string :ymindom
      t.string :yno404
      t.string :ymincookie
      t.string :ycookiefree
      t.string :ynofilter
      t.string :yimgnoscale
      t.string :yfavicon
      t.string :yemptysrc
      t.timestamps
    end
  end

  def self.down
    drop_table :grades
  end
end
