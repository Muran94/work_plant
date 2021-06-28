class CreateActivityLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :activity_logs do |t|
      t.references :contract, null: false, foreign_key: true
      t.integer :payment, null: false, comment: "報酬額（税抜き）"
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
