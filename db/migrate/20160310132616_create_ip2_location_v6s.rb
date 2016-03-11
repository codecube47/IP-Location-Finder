class CreateIp2LocationV6s < ActiveRecord::Migration
  def change
    create_table :ip2_location_v6s, id: false do |t|
      t.decimal :ip_from, precision: 39, scale: 0, :null => false
      t.decimal :ip_to, precision: 39, scale: 0, :null => false
      t.string :country_code, :limit => 2 ,:null => false
      t.string :country_name, :limit => 64, :null => false
    end

    execute "ALTER TABLE ip2_location_v6s ADD PRIMARY KEY (ip_from, ip_to);"
  end
end
