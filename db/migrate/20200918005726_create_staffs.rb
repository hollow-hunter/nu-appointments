class CreateStaffs < ActiveRecord::Migration[6.0]
  def change
    create_table :staffs do |t|
      t.text :name, null: false

      t.timestamps
    end
  end
end
