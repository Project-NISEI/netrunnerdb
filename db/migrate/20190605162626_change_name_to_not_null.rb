class ChangeNameToNotNull < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :name, false, default = "user"
  end
end
