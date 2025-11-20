class AddEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.json :data
      t.string :type

      t.timestamps
    end
  end
end
