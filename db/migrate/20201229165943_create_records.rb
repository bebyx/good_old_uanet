class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.string :name
      t.integer :first_year
      t.text :webarchive
      t.text :link
      t.text :comment

      t.timestamps
    end
  end
end
