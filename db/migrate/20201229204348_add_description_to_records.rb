class AddDescriptionToRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :description, :text
  end
end
