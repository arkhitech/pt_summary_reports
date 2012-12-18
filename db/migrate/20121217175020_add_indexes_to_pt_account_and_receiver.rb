class AddIndexesToPtAccountAndReceiver < ActiveRecord::Migration
  def change
    change_table :pt_accounts do |t|
      t.index [:email, :user_id], unique: true, name: 'by_email_user'
    end

    change_table :pt_report_receivers do |t|
      t.index [:pt_membership_id, :pt_report_schedule_id], unique: true, name: 'by_pt_membership_schedule'
    end 
  end
end
