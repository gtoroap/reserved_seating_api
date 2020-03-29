class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.string :date, null: false
      t.string :client_fullname
      t.integer :seats
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
