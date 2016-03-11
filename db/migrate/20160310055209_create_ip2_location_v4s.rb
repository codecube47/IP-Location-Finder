class CreateIp2LocationV4s < ActiveRecord::Migration
  def change
    create_table :ip2_location_v4s, id: false do |t|
      t.integer :ip_from, :limit => 8, :null => false
      t.integer :ip_to, :limit => 8, :null => false
      t.string :country_code, :limit => 2 ,:null => false
      t.string :country_name, :limit => 64, :null => false
    end

    execute "ALTER TABLE ip2_location_v4s ADD PRIMARY KEY (ip_from, ip_to);"
  end
end

