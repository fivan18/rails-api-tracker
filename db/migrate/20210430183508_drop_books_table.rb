class DropBooksTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :books
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
