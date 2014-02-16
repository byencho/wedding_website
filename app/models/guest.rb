class Guest < ActiveRecord::Base
  belongs_to :account

  validates :first_name, presence: true, length: { minimum: 2 } 
  validates :last_name, presence: true, length: { minimum: 2 } 
  #validates :age, numericality: true
  validates :guest_type, presence: true
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 18}, if: :is_family?
  validate :name_uniqueness
  validate :type_uniqueness
  #validate :age_if_child
  before_validation :strip_whitespace  

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def is_family?
    self.guest_type == "family"
  end

  private

  def strip_whitespace
    self.first_name = self.first_name ? self.first_name.strip() : ""
    self.last_name  = self.last_name ? self.last_name.strip() : ""
  end

  def name_uniqueness    
    self.account.guests.each do |guest|
      if guest.id != self.id && guest.name.strip().downcase == self.name.strip().downcase
        errors.add(:name, "is already taken in your account")
      end
    end
  end

  def type_uniqueness
    if self.guest_type == "me" || self.guest_type == "guest"
      self.account.guests.each do |guest|
        if guest.id != self.id && guest.guest_type == self.guest_type
          errors.add(:type, "#{self.type} is already taken in your account")
        end
      end
    end
  end

=begin
  def age_if_child    
    if self.guest_type == "family"
      puts " "
      puts "Age"
      puts self.age
      puts (self.age.to_s =~ /\A[+-]?\d+\Z/)

      valid_integer = (self.age.to_s =~ /\A[+-]?\d+\Z/)
      if valid_integer != 0
        errors.add(:age, "must be a valid number")
      end        
    end
  end
=end  

end
