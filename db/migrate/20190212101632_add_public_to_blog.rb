class AddPublicToBlog < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :public, :boolean, default: true
  end
end
