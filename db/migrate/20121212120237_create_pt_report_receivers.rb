class CreatePtReportReceivers < ActiveRecord::Migration
  def change
    create_table :pt_report_receivers do |t|
      t.references :pt_report_schedule
      t.integer :pt_membership_id

      t.timestamps
    end
    add_index :pt_report_receivers, :pt_report_schedule_id
  end
end
