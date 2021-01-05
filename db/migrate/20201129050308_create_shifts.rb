class CreateShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :shifts do |t|
      t.date :designated_on
      t.integer :kind
      t.boolean :determine, default: false, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
