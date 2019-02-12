# frozen_string_literal: true

class AddCategoryToBlog < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :category, :string
  end
end
