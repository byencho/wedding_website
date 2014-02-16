class Admin < ActiveRecord::Base
  # add devices columns
  devise :database_authenticatable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation

  before_validation :downcase_email

  def downcase_email
    self.email = self.email ? self.email.downcase : ""
  end
end
