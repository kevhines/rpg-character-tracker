class ChangeSecretColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column(:goods, :secret)
    remove_column(:notes, :secret)
  end
end
