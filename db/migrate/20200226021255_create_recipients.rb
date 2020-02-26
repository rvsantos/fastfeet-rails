class CreateRecipients < ActiveRecord::Migration[5.2]
  def change
    create_table :recipients do |t|
      t.string :name
      t.string :street
      t.string :complement
      t.string :state
      t.string :city
      t.integer :zip_code

      t.timestamps
    end
  end
end
