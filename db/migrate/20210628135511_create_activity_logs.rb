class CreateActivityLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :activity_logs do |t|
      t.references :contract, null: false, foreign_key: true
      t.integer    :payment, null: false, comment: "報酬額（税抜き）"
      t.datetime   :started_at, index: true, null: false, comment: "開始時間"
      t.datetime   :finished_at, index: true, comment: "終了時間"
      t.text       :comment, comment: "稼働内容等"

      t.timestamps
    end
  end
end
