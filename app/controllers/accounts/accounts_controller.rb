class Accounts::AccountsController < ApplicationController
  # Update layout for accounts
  layout 'accounts'

  before_filter :authenticate_account!
end
