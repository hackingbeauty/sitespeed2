class CreateUrls < ActiveRecord::Migration
  def self.up
    create_table :urls, :primary_key => :id do |t|
      t.integer :id
      t.binary :url_name
      t.string :country
      t.integer :country_rank
      t.integer :global_rank
      t.integer :country_reach_permillion
      t.integer :country_page_views_permillion
      t.integer :country_page_views_peruser
      t.timestamps
    end
    # add_index :urls, :last_update, :unique => true
  end

  def self.down
    drop_table :urls
  end
end
