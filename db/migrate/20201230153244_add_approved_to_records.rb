class AddApprovedToRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :approved, :boolean, default: false
  end
end
