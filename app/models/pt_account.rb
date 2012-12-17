# == Schema Information
#
# Table name: pt_accounts
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  api_token       :string(255)
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class PtAccount < ActiveRecord::Base
  belongs_to :user, inverse_of: :pt_accounts
  has_many :pt_report_schedules, dependent: :destroy, inverse_of: :pt_account

  attr_accessible :api_token, :email, :password, :password_confirmation
  
  before_save {|pt_account| 
    pt_account.email = pt_account.email.downcase
    encrypt_password(pt_account.password)
    }
                                                                                                                                                            
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i             

  before_create { raise "Password digest missing on new record" if password_digest.blank? }
          
  validates :email, presence: true,                                                                                                                         
    format: { with: VALID_EMAIL_REGEX },                                                                                                                      
    uniqueness: { case_sensitive: false, scope: :user_id }

  validates_confirmation_of :password
  validates :password, presence: true, on: :create

  validate :validate_pt_account_connectivity
  
  def validate_pt_account_connectivity
    if self.password.present? && self.password == self.password_confirmation && self.email.present?
      errors[:base] << 'Unable to connect to PivotalTracker with provided credentials' unless init_pt_client
    end
  end

  def init_pt_client
    @init_client ||= begin
      if self.api_token.blank?
        PivotalTracker::Client.token(self.email, self.password)
      else
        PivotalTracker::Client.token = self.api_token
      end
    rescue RestClient::Unauthorized
      nil
    end
  end
  
  def password                                                                                                                                              
    @password ||= encryptor.decrypt_and_verify(self.password_digest)
  end

  class << self
    def secret=(key)
      @@secret = key
    end
    
    def secret
      @@secret ||= PtSummaryReports::Configuration['secret_key']
    end
  end
  
  def encryptor
    ActiveSupport::MessageEncryptor.new(PtAccount.secret)    
  end
  private :encryptor
  
  def encrypt_password(password)
    self.password_digest = encryptor.encrypt_and_sign(password)
  end
  private :encrypt_password
  
  def password=(unencrypted_password)
    unless unencrypted_password.blank?
      @password = unencrypted_password
      encrypt_password(unencrypted_password)
    end
    
  end
end
