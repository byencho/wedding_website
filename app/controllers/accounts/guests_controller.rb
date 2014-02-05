class Accounts::GuestsController < Accounts::AccountsController

  def create
    if !params[:guest]
      render :json => { :success => false, message: "Guest information missing"}
    end

    guest = Guest.new(account: current_account)
    guest.first_name = params[:guest][:first_name]
    guest.last_name = params[:guest][:last_name]
    guest.guest_type = params[:guest][:guest_type]
    guest.attending = params[:guest][:attending]

    if (guest.guest_type == "family")
      guest.age = params[:guest][:age]
    end

    if guest.save
      render json: { success: true, guest: guest.as_json }
    else
      render json: { success: false, message: guest.errors.full_messages }
    end
  end

  def update
    if !params[:guest]
      render :json => { :success => false, message: "Guest information missing"}
    end

    guest = Guest.where(id: params[:id]).first

    if guest.nil?
      render json: { success: false, message: "Sorry, we couldn't find that guest" }
    else
      guest.first_name = params[:guest][:first_name]
      guest.last_name = params[:guest][:last_name]
      guest.guest_type = params[:guest][:guest_type]
      guest.attending = params[:guest][:attending]

      if (guest.guest_type == "family")
        guest.age = params[:guest][:age]
      end

      if guest.save
        render json: { success: true, guest: guest.as_json }
      else
        render json: { success: false, message: guest.errors.full_messages }
      end
    end
  end

  def destroy
    guest = Guest.where(id: params[:id]).first

    if guest.nil?
      render json: { success: false, message: "Sorry, we couldn't find that guest" }
    else
      if guest.destroy
        render json: { success: true }
      else
        render json: { success: false, message: guest.errors.full_messages }
      end
    end
  end

end