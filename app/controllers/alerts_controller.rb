class AlertsController < ApplicationController
  before_action :set_alert, only: %i[ show edit update destroy ]
  before_action :authorize_request
  
  def index
    @alerts = Alert.all
    respond_to do |format|
        format.html { render :index, :layout => false  }
        format.json { render @alerts, status: :created }
    end
  end

  def show
  end

  def new
    @alert = Alert.new
  end

  def edit
  end

  def create
    @alert = Alert.new(alert_params)
    if alert_params[:alert_type] == 'portal_opened' || alert_params[:alert_type] == 'portal_closed'
      if @alert.save
        render json: @alert, status: :created
      else
        render json: { errors: @alert.errors}, status: :unprocessable_entity
      end
    else
      render json: { errors: "Type should be portal_opened or portal_closed"}, status: :unprocessable_entity
    end
  end

  def update
    if @alert.update(alert_params)
      render json: @alert, status: :ok
    else
      render json: { errors: @alert.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    @alert.destroy
    render json: @alert, status: :ok
  end

  private
    def set_alert
      @alert = Alert.find(params[:id])
    end

    def alert_params
      params.require(:alert).permit(:alert_type, :description, :origin , tags:[])
    end
end
