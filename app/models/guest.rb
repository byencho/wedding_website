class Guest < ActiveRecord::Base
  belongs_to :account

  validates :first_name, presence: true, length: { minimum: 2, maximum: 140 } 
  validates :last_name, presence: true, length: { minimum: 2, maximum: 140 }  
  validates :diet, length: { maximum: 140 } 
  validates :title, length: { maximum: 140 } 
  validates :guest_type, presence: true
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 18}, if: :is_family?
  validate :name_uniqueness
  validate :type_uniqueness
  before_validation :strip_whitespace

  def name
    if self.guest_type != "family" && self.title
      "#{self.title} #{self.first_name} #{self.last_name}"
    else
      "#{self.first_name} #{self.last_name}"
    end
  end

  private

  def is_family?
    self.guest_type == "family"
  end

  def name_uniqueness    
    self.account.guests.each do |guest|
      if guest.id != self.id && guest.name.strip().downcase == self.name.strip().downcase
        errors.add(:name, "is already taken in your account")
      end
    end
  end

  def strip_whitespace
    self.diet = self.diet ? self.diet.strip() : ""
    self.title = self.title ? self.title.strip() : ""    
    self.first_name = self.first_name ? self.first_name.strip() : ""
    self.last_name  = self.last_name ? self.last_name.strip() : ""
  end

  def type_uniqueness
    if self.guest_type == "me" || self.guest_type == "guest"
      self.account.guests.each do |guest|
        if guest.id != self.id && guest.guest_type == self.guest_type
          errors.add(:type, "#{self.guest_type} is already taken in your account")
        end
      end
    end
  end

end
