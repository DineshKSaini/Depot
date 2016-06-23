class CreateRoleusers < ActiveRecord::Migration
  def change
    create_table :roleusers do |t|
      t.references :user
      t.references :role

      t.timestamps
    end
    add_index :roleusers, :user_id
    add_index :roleusers, :role_id
  end
end
