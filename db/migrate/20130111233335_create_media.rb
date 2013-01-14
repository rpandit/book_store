class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :title
      t.string :author
      t.string :publisher
      t.date :published_at
      t.decimal :unit_cost
      t.string :category

      t.timestamps
    end
  end
end
