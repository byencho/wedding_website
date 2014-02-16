class Admin::GuestsController < Admin::AdminController
  def index
    @guests = Guest.all.sort_by(&:first_name)
  end
end
