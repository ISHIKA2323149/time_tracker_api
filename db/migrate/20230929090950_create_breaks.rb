class CreateBreaks < ActiveRecord::Migration[5.2]
  def change
    create_table :breaks do |t|
      t.references :user, foreign_key: true
      t.datetime :break_in_time
      t.datetime :break_out_time

      t.timestamps
    end
  end
end
