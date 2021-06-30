class CreateContracts < ActiveRecord::Migration[6.1]
  def change
    create_table :contracts do |t|
      t.references :client, null: false, foreign_key: true
      t.integer    :hourly_payment, null: false, comment: "時給（税抜）"
      t.datetime   :expired_at, comment: "契約終了日時"
      t.integer    :expired_reason, comment: "契約終了理由"

      t.timestamps
    end
  end
end
