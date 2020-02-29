class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.belongs_to :recipient, foreign_key: true
      t.belongs_to :deliveryman, foreign_key: true
      t.string :product
      t.datetime :canceled_at
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
