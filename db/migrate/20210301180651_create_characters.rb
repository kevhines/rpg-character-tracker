class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :class
      t.integer :level
      t.string :bio
      t.string :description
      t.integer :user_id
    end
  end
end
