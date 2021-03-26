class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :status
      t.string :customer_name
      t.string :airtable_id

      t.timestamps
    end
  end
end
