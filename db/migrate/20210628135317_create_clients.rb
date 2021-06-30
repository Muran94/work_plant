class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.references :user, null: false, foreign_key: true
      t.string     :name, null: false
      t.text       :logo_data

      t.timestamps
    end
  end
end
