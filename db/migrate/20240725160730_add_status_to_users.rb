class AddStatusToUsers < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:users, :status)
      add_column :users, :status, :string, default: 'normal'
    end
  end
end
