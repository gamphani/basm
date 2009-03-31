class CreateServers < ActiveRecord::Migration
  def self.up
    create_table :servers do |t|
      t.column :name, :string, :limit => 32, :null => false
      t.column :location, :string
      t.column :created_at, :timestamp
    end
  end

  def self.down
    drop_table :servers
  end
end
