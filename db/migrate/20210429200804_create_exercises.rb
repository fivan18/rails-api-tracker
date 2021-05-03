class CreateExercises < ActiveRecord::Migration[6.1]
  def change
    create_table :exercises do |t|
      t.string :name, null: false
      t.string :link
      t.integer :sets, null: false
      t.integer :reps, null: false
      t.integer :rest, null: false
      t.string :tempo, null: false
      t.references :routine, foreign_key: true

      t.timestamps
    end
  end
end
