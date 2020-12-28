class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.string :code, null: false
      t.string :email, null: false
      t.datetime :expires_in, null: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
