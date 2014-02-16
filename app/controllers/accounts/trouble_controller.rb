class Accounts::TroubleController < Accounts::AccountsController
  skip_before_filter :authenticate_account!

  def show
    # Static
  end
end
