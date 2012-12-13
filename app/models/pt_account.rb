class PtAccount < ActiveRecord::Base
  belongs_to :user
  has_many :pt_report_schedules, dependent: :destroy

  attr_accessible :api_token, :email, :password, :password_confirmation
  has_secure_password
  
  before_save {|pt_account| pt_account.email = pt_account.email.downcase}
                                                                                                                                                            
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i             
  
  validates :email, presence: true,                                                                                                                         
  format: { with: VALID_EMAIL_REGEX },                                                                                                                      
  uniqueness: { case_sensitive: false, scope: :user_id }

  def decrypted_password                                                                                                                                              
    BCrypt::Password.new(password_digest)                                                                                                                   
  end
end
