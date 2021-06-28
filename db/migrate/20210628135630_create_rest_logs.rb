class CreateRestLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :rest_logs do |t|
      t.references :activity_log, null: false, foreign_key: true
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
