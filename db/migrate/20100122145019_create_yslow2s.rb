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
      t.integer :s
      t.integer :i
      t.integer :lt
      t.integer :g
      t.integer :w_c
      t.integer :r_c
      t.text :stats
      t.text :stats_c
      t.text :comps
      t.timestamps
    end
    #add_index :yslow2s, :url_id, :unique => true
  end

  def self.down
    drop_table :yslow2s
  end
end
