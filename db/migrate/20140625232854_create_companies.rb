class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :description
      t.integer :company_size
      t.string :industry

      t.timestamps
    end
    
    add_index :name, unique: true
    add_index :company_size
    add_index :industry
  end
end
