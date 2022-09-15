class CreateTour < ActiveRecord::Migration[7.0]
  def change
    create_table :tours do |t|
      t.string :title
      t.decimal :duration
      t.string :city
      t.string :description
      t.decimal :cost
      t.string :photo
      t.references :user, null: false, foreign_key: { to_table: 'users' }


      t.timestamps
    end
  end
end
