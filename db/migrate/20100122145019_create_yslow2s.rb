class CreateYslow2s < ActiveRecord::Migration
  def self.up
    create_table :yslow2s, :primary_key => :id do |t|
      t.integer :id
      t.integer :url_id
      t.integer :ip
      t.text :user_agent
      t.integer :w
      t.integer :o
      t.integer :r
      t.text :i
      t.integer :lt
      t.integer :ynumreq
      t.integer :ycdn
      t.integer :yexpires
      t.integer :ycompress
      t.integer :ycsstop
      t.integer :yjsbottom
      t.integer :yexpressions
      t.integer :yexternal
      t.integer :ydns
      t.integer :yminify
      t.integer :yredirects
      t.integer :ydupes
      t.integer :yetags
      t.integer :yxhr
      t.integer :yxhrmethod
      t.integer :ymindom
      t.integer :yno404
      t.integer :ymincookie
      t.integer :ycookiefree
      t.integer :ynofilter
      t.integer :yimgnoscale
      t.integer :yfavicon
      t.text :details

      t.timestamps
    end
    add_index :yslow2s, :url_id, :unique => true
  end

  def self.down
    drop_table :yslow2s
  end
end
