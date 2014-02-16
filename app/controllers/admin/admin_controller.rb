class Admin::AdminController < ApplicationController
  # Update layout for accounts
  layout 'accounts'

  before_filter :authenticate_admin!
end
