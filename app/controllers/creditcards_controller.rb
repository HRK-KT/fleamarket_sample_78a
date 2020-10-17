class CreditcardsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @creditcard = Creditcard.new
  end
  
  def create
    @creditcard = Creditcard.new(creditcard_params)
    if @creditcard.save
      redirect_to root_path 
    else
      render :new
    end
  end


  def edit
  end

  def update
    @creditcard = Creditcard.find(params[:id])
    if @creditcard.update(creditcard_params)
      redirect_to root_path
    else
      render :edit
    end
  end


  private

  def creditcard_params
    params.permit(:card_id, :exp_year, :exp_month, :cvc).merge(user_id: current_user.id)
  end

end
