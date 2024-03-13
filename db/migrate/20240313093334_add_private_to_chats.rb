class AddPrivateToChats < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :private, :boolean, default: false
  end
end
