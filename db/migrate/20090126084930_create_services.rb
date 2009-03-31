class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.column :name, :string
      t.column :description, :string
      t.column :created_at, :timestamp
    end
    Service.create :name => "Battery", :description => "Monitors Voltages of batteries"
  end

  def self.down
    drop_table :services
  end
end
