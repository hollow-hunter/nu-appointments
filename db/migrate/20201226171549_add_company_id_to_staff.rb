class AddCompanyIdToStaff < ActiveRecord::Migration[6.0]
  def change
    add_reference :staffs, :company, null: false, foreign_key: true
  end
end
