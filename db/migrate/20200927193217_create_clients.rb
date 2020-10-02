class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :phone, null: false
      t.string :email, null: false
      t.string :code

      t.index :code, unique: true
      t.timestamps
    end
  end
end
