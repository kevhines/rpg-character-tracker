class AddTimestampsToNotes < ActiveRecord::Migration[5.2]
  def change
    add_timestamps(:notes,null:true)
  end
end
