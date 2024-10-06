# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  validates :session_token, presence: true, uniqueness: true
  validates :username, length: { minimum:3,  maximum:40 }, format: { without: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :email, length: { minimum:3, maximum:100 }, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :password, length: { minimum:6, maximum:40 }, allow_nil: true
  
  before_validation :ensure_session_token

  has_many :tracks, foreign_key: :artist_id, dependent: :destroy
  has_many :playlists, foreign_key: :publisher_id, class_name: :Playlist, dependent: :destroy
  has_one_attached :photo

  attr_reader :password
  
  def is_password?(password) 
    BCrypt::Password.new(self.password_digest) == password
  end

  def self.find_by_credentials(credential, password)
    if URI::MailTo::EMAIL_REGEXP.match?(credential) 
      user = User.find_by(email: credential);
    else
      user = User.find_by(username: credential);
    end
    return user if user&.is_password?(password)
    return nil;
  end


  def reset_session_token!
    self.session_token = generate_unique_session_token
    self.save!
    return self.session_token
  end
# -----------------------------------------------------------------------------
  private
  
  def ensure_session_token
    self.session_token ||= generate_unique_session_token
  end

  def generate_unique_session_token
      while true do
        session_token = SecureRandom.base64
        return session_token unless User.exists?(session_token: session_token)
      end
  end
end
