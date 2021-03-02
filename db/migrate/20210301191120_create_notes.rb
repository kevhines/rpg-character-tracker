class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :content
      t.boolean :secret
      t.integer :user_id
    end
  end
end
