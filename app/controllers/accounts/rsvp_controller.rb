class Accounts::RsvpController < Accounts::AccountsController
  def show    
    @account = current_account
  end
end
