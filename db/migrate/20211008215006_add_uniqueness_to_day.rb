class AddUniquenessToDay < ActiveRecord::Migration[6.1]
  def change
    add_index :routines, [:day, :user_id], unique: true
  end
end
