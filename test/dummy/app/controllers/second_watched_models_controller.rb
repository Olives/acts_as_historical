class SecondWatchedModelsController < ApplicationController
  # GET /second_watched_models
  # GET /second_watched_models.json
  def index
    @second_watched_models = SecondWatchedModel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @second_watched_models }
    end
  end

  # GET /second_watched_models/1
  # GET /second_watched_models/1.json
  def show
    @second_watched_model = SecondWatchedModel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @second_watched_model }
    end
  end

  # GET /second_watched_models/new
  # GET /second_watched_models/new.json
  def new
    @second_watched_model = SecondWatchedModel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @second_watched_model }
    end
  end

  # GET /second_watched_models/1/edit
  def edit
    @second_watched_model = SecondWatchedModel.find(params[:id])
  end

  # POST /second_watched_models
  # POST /second_watched_models.json
  def create
    @second_watched_model = SecondWatchedModel.new(params[:second_watched_model])

    respond_to do |format|
      if @second_watched_model.save
        format.html { redirect_to @second_watched_model, notice: 'Second watched model was successfully created.' }
        format.json { render json: @second_watched_model, status: :created, location: @second_watched_model }
      else
        format.html { render action: "new" }
        format.json { render json: @second_watched_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /second_watched_models/1
  # PUT /second_watched_models/1.json
  def update
    @second_watched_model = SecondWatchedModel.find(params[:id])

    respond_to do |format|
      if @second_watched_model.update_attributes(params[:second_watched_model])
        format.html { redirect_to @second_watched_model, notice: 'Second watched model was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @second_watched_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /second_watched_models/1
  # DELETE /second_watched_models/1.json
  def destroy
    @second_watched_model = SecondWatchedModel.find(params[:id])
    @second_watched_model.destroy

    respond_to do |format|
      format.html { redirect_to second_watched_models_url }
      format.json { head :ok }
    end
  end
end
