class CreateObservations < ActiveRecord::Migration
  def self.up
    create_table :observations do |t|
      t.column :server_id, :integer
      t.column :service_id, :integer
      t.column :observation_key, :string, :limit => 32, :null => false
      t.column :observation_value, :float
      t.column :observation_date_time, :datetime
      t.column :created_at, :timestamp
    end
  end

  def self.down
    drop_table :observations
  end
end
