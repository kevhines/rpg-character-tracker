class CreateGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :goods do |t|
      t.string :name
      t.integer :quantity
      t.boolean :secret
      t.integer :user_id
    end
  end
end
