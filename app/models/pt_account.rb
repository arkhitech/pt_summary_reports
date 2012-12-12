class PtAccount < ActiveRecord::Base
  belongs_to :user
  attr_accessible :api_token, :email, :password_digest

  has_many :pt_report_schedule, dependent: :destroy
end
