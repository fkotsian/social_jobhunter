class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :street1
      t.string :street2
      t.string :city
      t.string :region
      t.string :postal_code
      t.string :country, default: 'USA'

      t.timestamps null: false
    end
  end
end
