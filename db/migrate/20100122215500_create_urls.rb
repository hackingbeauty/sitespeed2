class CreateUrls < ActiveRecord::Migration
  def self.up
    create_table :urls, :primary_key => :id do |t|
      t.integer :id
      t.binary :url
      t.timestamp :last_update
      t.timestamp :last_event_update
      t.integer :w
      t.integer :o
      t.integer :r
      t.integer :ps_w
      t.float :ps_o
      t.integer :ps_l
      t.integer :ps_r
      t.integer :ps_t

      t.timestamps
    end
    add_index :urls, :last_update, :unique => true
  end

  def self.down
    drop_table :urls
  end
end
