class Users < ActiveRecord::Migration
        def self.up
                create_table :users do |t|
                        t.column :uname, :string, :limit => 15, :null => false
                        t.column :passwd, :string, :limit => 12, :null => true
                        t.column :role, :string, :limit => 13, :null => false

                        t.timestamps
                end
        end

        def self.down
                drop_table :users
        end
end
