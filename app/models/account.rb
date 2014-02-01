class Account < ActiveRecord::Base
  # add devices columns
  devise :database_authenticatable, :registerable, :recoverable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation

  has_many :guests, dependent: :destroy

  # TODO Decide if :validatable is necessary here

  before_validation :downcase_email

  def downcase_email
    self.email = self.email ? self.email.downcase : ""
  end

end
