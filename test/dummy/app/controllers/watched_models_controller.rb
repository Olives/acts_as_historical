class WatchedModelsController < ApplicationController
  # GET /watched_models
  # GET /watched_models.json
  def index
    @watched_models = WatchedModel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @watched_models }
    end
  end

  # GET /watched_models/1
  # GET /watched_models/1.json
  def show
    @watched_model = WatchedModel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @watched_model }
    end
  end

  # GET /watched_models/new
  # GET /watched_models/new.json
  def new
    @watched_model = WatchedModel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @watched_model }
    end
  end

  # GET /watched_models/1/edit
  def edit
    @watched_model = WatchedModel.find(params[:id])
  end

  # POST /watched_models
  # POST /watched_models.json
  def create
    @watched_model = WatchedModel.new(params[:watched_model])

    respond_to do |format|
      if @watched_model.save
        format.html { redirect_to @watched_model, notice: 'Watched model was successfully created.' }
        format.json { render json: @watched_model, status: :created, location: @watched_model }
      else
        format.html { render action: "new" }
        format.json { render json: @watched_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /watched_models/1
  # PUT /watched_models/1.json
  def update
    @watched_model = WatchedModel.find(params[:id])

    respond_to do |format|
      if @watched_model.update_attributes(params[:watched_model])
        format.html { redirect_to @watched_model, notice: 'Watched model was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @watched_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /watched_models/1
  # DELETE /watched_models/1.json
  def destroy
    @watched_model = WatchedModel.find(params[:id])
    @watched_model.destroy

    respond_to do |format|
      format.html { redirect_to watched_models_url }
      format.json { head :ok }
    end
  end
end
