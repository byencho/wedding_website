class Admin::AccountsController < Admin::AdminController
  def index
    @accounts = Account.all.sort_by(&:guests_updated_at).reverse
    @account_count = Account.count
  end
end
