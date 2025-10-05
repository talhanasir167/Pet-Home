class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.decimal :total_amount
      t.string :payment_provider
      t.string :payment_reference

      t.timestamps
    end
  end
end
