class CreateRestLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :rest_logs do |t|
      t.references :activity_log, null: false, foreign_key: true
      t.datetime   :started_at, index: true, null: false, comment: "休憩開始日時"
      t.datetime   :finished_at, index: true, comment: "休憩終了日時"

      t.timestamps
    end
  end
end
