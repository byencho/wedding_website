class Admin::GuestsController < Admin::AdminController
  def index
    @guests = Guest.all.sort_by(&:updated_at).reverse

    attending_guests = Guest.where(attending: true)
    attending_adults = attending_guests.where("GUEST_TYPE IN (?)", %w(me guest other))
    attending_children = attending_guests.where(guest_type: "family")
    attending_children_0_to_2 = attending_children.where(age: 0..2)
    attending_children_3_to_12 = attending_children.where(age: 3..12)
    attending_children_13_plus = attending_children.where("AGE > (?)", 12)

    @guest_count = Guest.count
    @coming_count = attending_guests.count  
    @coming_count_adults_and_children_13_plus = attending_adults.count + attending_children_13_plus.count
    @coming_count_children_3_to_12 = attending_children_3_to_12.count
    @coming_count_children_0_to_2 = attending_children_0_to_2.count
    @not_coming_count = Guest.where(attending: false).count
  end
end
