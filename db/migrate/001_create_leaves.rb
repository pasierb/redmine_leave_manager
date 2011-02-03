class CreateLeaves < ActiveRecord::Migration
  def self.up
    create_table :leaves do |t|
      t.column :date, :date
      t.column :status, :integer
      t.column :user_id, :integer
      t.foreign_key :user_id, :users, :id, :on_delete => :set_null, :on_update => :cascade
    end
  end

  def self.down
    drop_table :leaves
  end
end
