class AddSecretColumn < ActiveRecord::Migration[5.2]
  def change
    add_column(:notes, :secret, :integer, default: 0)
    add_column(:goods, :secret, :integer, default: 0)
  end
end
