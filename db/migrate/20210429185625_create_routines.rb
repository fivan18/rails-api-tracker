class CreateRoutines < ActiveRecord::Migration[6.1]
  def change
    create_table :routines do |t|
      t.date :day, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end