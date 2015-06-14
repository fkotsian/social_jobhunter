class RemoveDefaultCountryFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :country, :string
    add_column :locations, :country, :string
  end
end
