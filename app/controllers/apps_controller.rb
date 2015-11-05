class AppsController < ApplicationController
  include UpdateTracking
  skip_before_action :verify_authenticity_token, only: :log

  def log
    return not_authenticated unless (@app = app.find_by_ip(request.ip))
    log = @app.logs.new(params.require(:log).permit(:severity, :message))
    if log.save
      render json: log.to_json
    else
      render json: { errors: log.errors }.to_json, status: :bad_request
    end
  end

  def index
    @apps = App.includes(:logs).page(params[:page]).per(12)
  end

  def show
    @app = find_app
  end

  def new
    @app = App.new
  end

  def edit
    @app = find_app
  end

  def create
    @app = App.new(app_params)
    @app.user = current_user
    if @app.save
      redirect_to @app, notice: "App was successfully created."
    else
      flash[:error] = @app.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    @app = find_app
    if @app.update(app_params)
      track_update(@app)
      redirect_to @app, notice: "App was successfully updated."
    else
      flash[:error] = @app.errors.full_messages.to_sentence
      render :edit
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app = find_app
    @app.destroy
    redirect_to apps_url, notice: "App was successfully destroyed."
  end

  private

    def find_app
      App.includes(:logs).find(params[:id])
    end

    def app_params
      params.require(:app).permit(:name, :ip)
    end

    def not_authenticated
      render json: "Not an authenticated IP address".to_json, status: :forbidden
    end
end
