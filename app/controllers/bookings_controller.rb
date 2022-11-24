class BookingsController < ApplicationController
  before_action :set_raclette, only: %i[new create edit update destroy show]
  before_action :set_booking, only: %i[edit update show]

  def new
    @booking = Booking.new
    authorize @booking
  end

  def create
    @booking = Booking.new(params_booking)
    @booking.user = current_user
    @booking.raclette = @raclette
    authorize @booking
    if @booking.save
      redirect_to raclette_booking_path(@raclette, @booking)
    else
      render "raclettes/show", status: :unprocessable_entity
    end
  end

  def index
    @bookings = policy_scope(Booking)
  end

  def edit
    authorize @booking
  end

  def update
    authorize @booking
    @booking.update(params_booking)
    redirect_to raclette_booking_path(@raclette, @booking)
  end

  def show
    authorize @booking
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def set_raclette
    @raclette = Raclette.find(params[:raclette_id])
  end

  def params_booking
    params.require(:booking).permit(:date, :description, :raclette_id, :status, :big_eater, :normal_eater, :small_eater)
  end

end
