class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :url, null: false
      t.string :overview, null: false
      t.text :background, null: false
      t.text :usage, null: false
      t.text :ingenuity, null: false
      t.text :features, null: false
      t.text :technology, null: false
      t.text :other

      t.timestamps
    end
  end
end
