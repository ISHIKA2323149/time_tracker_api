class CreateCheckouts < ActiveRecord::Migration[5.2]
  def change
    create_table :checkouts do |t|
      t.references :user, foreign_key: true
      t.datetime :check_out_time

      t.timestamps
    end
  end
end
