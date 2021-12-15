class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :name
      t.string :title
      t.string :body
      t.string :genre
      t.string :image

      t.timestamps
    end
  end
end
