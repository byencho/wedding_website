class Admin::AccountsController < Admin::AdminController
  def index
    @accounts = Account.all.sort_by(&:updated_at)
  end
end
