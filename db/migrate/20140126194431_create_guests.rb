class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.integer :account_id, null: false
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :guest_type, null: false, default: "me"
      t.boolean :attending, null: false, default: true
      t.timestamps
    end
  end
end
