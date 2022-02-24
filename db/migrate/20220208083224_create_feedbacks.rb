class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :feedbacks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.text :good_point, null: false
      t.text :improvement_point, null: false
      t.text :other

      t.timestamps
    end
  end
end
