class AddMediaIndices < ActiveRecord::Migration
  def up
    add_index(:media, :title)
    add_index(:media, :publisher)
    add_index(:media, :category)
  end

  def down
    remove_index(:media, :column => :title)
    remove_index(:media, :column => :publisher)
    remove_index(:media, :column => :category)
  end
end
