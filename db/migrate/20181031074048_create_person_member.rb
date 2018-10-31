class CreatePersonMember < ActiveRecord::Migration[5.1]
  def change
    create_table :person_members do |t|
      t.integer :organization_id
      t.string :name
      t.string :email
      t.string :phone
      t.string :avatar

      t.timestamps
    end

    add_index :person_members, :organization_id
  end
end
