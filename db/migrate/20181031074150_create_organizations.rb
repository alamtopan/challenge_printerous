class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.integer :account_manager_id
      t.string :name
      t.string :email
      t.string :phone
      t.string :website
      t.string :logo

      t.timestamps
    end

    add_index :organizations, :account_manager_id
  end
end
