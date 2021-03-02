class AddDefaultToSecrets < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:goods, :secret, false)
    change_column_default(:notes, :secret, false)
  end
end
