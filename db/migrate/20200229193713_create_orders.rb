class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :recipient, foreign_key: true
      t.references :deliveryman, foreign_key: true
      t.string :product
      t.datetime :canceled_at
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
