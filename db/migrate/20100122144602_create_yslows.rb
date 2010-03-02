class CreateYslows < ActiveRecord::Migration
  def self.up
    create_table :yslows, :primary_key => :id do |t|
      t.integer :id
      t.integer :url_id
      t.integer :ip
      t.text :user_agent
      t.integer :w
      t.integer :o
      t.text :u
      t.integer :r
      t.integer :numcomps
      t.integer :cdn
      t.integer :expires
      t.integer :gzip
      t.integer :cssattop
      t.integer :jsatbottom
      t.integer :expression
      t.integer :domains
      t.integer :obfuscate
      t.integer :redirects
      t.integer :jstwice
      t.integer :etags

      t.timestamps
    end
  end

  def self.down
    drop_table :yslows
  end
end
