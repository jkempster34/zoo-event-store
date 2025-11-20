class AddOnboarding < ActiveRecord::Migration[8.1]
  def change
    create_table :onboardings do |t|
      t.string :status
      t.date :date_received

      t.references :animal

      t.timestamps
    end

    remove_column :animals, :date_received
  end
end
