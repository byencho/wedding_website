class Admin::GuestsController < Admin::AdminController
  def index
    @guests = Guest.all.sort_by(&:updated_at).reverse
    @guest_count = Guest.count
    @coming_count = Guest.where(attending: true).count
    @not_coming_count = Guest.where(attending: false).count
  end
end
