class ChangeDatatypeOnCompaniesDescriptionFromStringToText < ActiveRecord::Migration
  def up
    change_column :companies, :description, :text, :limit => 755
  end

  def down
    change_column :companies, :description, :string
 end
end
