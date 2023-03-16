class AddOpenAiKeyToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :open_ai_key, :string
  end
end
