class AddUserIdToRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :records, :user_id, :int
  end
end
