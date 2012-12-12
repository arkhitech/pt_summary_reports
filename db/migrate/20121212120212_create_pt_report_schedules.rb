class CreatePtReportSchedules < ActiveRecord::Migration
  def change
    create_table :pt_report_schedules do |t|
      t.references :pt_account
      t.time :report_time

      t.timestamps
    end
    add_index :pt_report_schedules, :pt_account_id
  end
end
