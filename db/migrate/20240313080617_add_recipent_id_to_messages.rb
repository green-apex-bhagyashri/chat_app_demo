class AddRecipentIdToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :recipient_id, :integer
  end
end
