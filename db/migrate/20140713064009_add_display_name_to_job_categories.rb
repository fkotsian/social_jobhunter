class AddDisplayNameToJobCategories < ActiveRecord::Migration
  def change
    add_column :job_categories, :display_name, :string
    add_index  :job_categories, :display_name, unique: true
  end
end
