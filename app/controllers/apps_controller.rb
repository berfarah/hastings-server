class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: :external

  def log
    return not_authenticated unless (@app = app.find_by_ip(request.ip))
    log = @app.logs.new(params.require(:log).permit(:severity, :message))

    if log.save
      render json: log.to_json
    else
      render json: { errors: log.errors }.to_json, status: :bad_request
    end
  end

  def search
    @apps = App.search(params[:query]).records.includes(:logs).page(params[:page]).per(12)
    render :index
  end

  def index
    @apps = App.includes(:logs).page(params[:page]).per(12)
  end

  def show
  end

  def new
    @app = App.new
  end

  def edit
  end

  def create
    @app = App.new(app_params)

    respond_to do |format|
      if @app.save
        format.html { redirect_to @app, notice: 'app was successfully created.' }
        format.json { render :show, status: :created, location: @app }
      else
        flash[:error] = @app.errors.full_messages.to_sentence
        format.html { render :new }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @app.update(app_params)
        format.html { redirect_to @app, notice: 'app was successfully updated.' }
        format.json { render :show, status: :ok, location: @app }
      else
        flash[:error] = @app.errors.full_messages.to_sentence
        format.html { render :edit }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app.destroy
    respond_to do |format|
      format.html { redirect_to apps_url, notice: 'app was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.includes(:logs).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:app).permit(:name, :ip)
    end

    def not_authenticated
      render json: 'Not an authenticated IP address'.to_json, status: :forbidden
    end
end
