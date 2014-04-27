class Account < ActiveRecord::Base
  # add devices columns
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation

  has_many :guests, dependent: :destroy
  before_validation :downcase_email

  def downcase_email
    self.email = self.email ? self.email.downcase : ""
  end

  def guests_updated_at
    guests_updated_at = self.updated_at
    guests.each do |guest|
      if guest.updated_at > guests_updated_at
        guests_updated_at = guest.updated_at
      end
    end
    guests_updated_at
  end

end
