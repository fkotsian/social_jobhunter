class AddIndexesToLocations < ActiveRecord::Migration
  def change
    add_index :locations, :street1
    add_index :locations, :street2
    add_index :locations, :city
    add_index :locations, :region
    add_index :locations, :country
    add_index :locations, :postal_code
  end
end
