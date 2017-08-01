class User < ApplicationRecord

  attr_accessor :login

  validates :username, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9_\-\.]*\z/ }


  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)

    if login
      where(conditions.to_hash)
        .where('LOWER(username) = :value OR LOWER(email) = :value', value: login.downcase)
        .first
    else
      where(conditions.to_hash).first
    end
  end


  # Add :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

end
