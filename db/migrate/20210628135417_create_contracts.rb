class CreateContracts < ActiveRecord::Migration[6.1]
  def change
    create_table :contracts do |t|
      t.references :client, null: false, foreign_key: true
      t.integer :hourly_wage, null: false, comment: "時給（税抜）"

      t.timestamps
    end
  end
end
