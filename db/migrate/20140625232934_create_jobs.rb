class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.references :company, index: true, null: false
      t.string :category
      t.string :url
      t.integer :salary_bottom
      t.integer :salary_top

      t.timestamps
    end
    
    add_index :title
    add_index :url, unique: true
    add_index :category
    add_index :salary_bottom
    add_index :salary_top
  end
end
