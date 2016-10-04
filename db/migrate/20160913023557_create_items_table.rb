class CreateItemsTable < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :description
      t.datetime :due_at
      t.boolean :completed
      t.integer :user_id
      t.timestamps
    end
  end
end
