class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events, :primary_key => :id do |t|
      t.int :id
      t.string :type
      t.binary :url_prefix
      t.text :title
      t.timestamp :start
      t.timestamp :end
      t.binary :resource_url

      t.timestamps
    end
    add_index :events, :start, :unique => true
  end

  def self.down
    drop_table :events
  end
end
