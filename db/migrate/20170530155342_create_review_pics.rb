class CreateReviewPics < ActiveRecord::Migration[5.0]
  def change
    create_table :review_pics do |t|
      t.integer :review_id
      t.string :avatar

      t.timestamps
    end
  end
end
