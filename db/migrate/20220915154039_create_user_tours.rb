class CreateUserTours < ActiveRecord::Migration[7.0]
  def change
    create_table :user_tours do |t|
      t.references :user, foreign_key: true, index: true
      t.references :tour, foreign_key: true, index: true
      t.integer :persons_number
      t.date :reservation_date

      t.timestamps
    end
  end
end
