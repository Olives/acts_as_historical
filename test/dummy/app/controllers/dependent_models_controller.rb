class DependentModelsController < ApplicationController
  # GET /dependent_models
  # GET /dependent_models.json
  def index
    @dependent_models = DependentModel.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dependent_models }
    end
  end

  # GET /dependent_models/1
  # GET /dependent_models/1.json
  def show
    @dependent_model = DependentModel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dependent_model }
    end
  end

  # GET /dependent_models/new
  # GET /dependent_models/new.json
  def new
    @dependent_model = DependentModel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dependent_model }
    end
  end

  # GET /dependent_models/1/edit
  def edit
    @dependent_model = DependentModel.find(params[:id])
  end

  # POST /dependent_models
  # POST /dependent_models.json
  def create
    @dependent_model = DependentModel.new(params[:dependent_model])

    respond_to do |format|
      if @dependent_model.save
        format.html { redirect_to @dependent_model, notice: 'Dependent model was successfully created.' }
        format.json { render json: @dependent_model, status: :created, location: @dependent_model }
      else
        format.html { render action: "new" }
        format.json { render json: @dependent_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dependent_models/1
  # PUT /dependent_models/1.json
  def update
    @dependent_model = DependentModel.find(params[:id])
    if params[:dependent_model][:watched_model_id].to_i != @dependent_model.watched_model_id
      @dependent_model.watched_model.dependent_models.delete(@dependent_model)
    end
    if params[:dependent_model][:second_watched_model_id].to_i != @dependent_model.second_watched_model_id
      @dependent_model.second_watched_model.dependent_models.delete(@dependent_model)
    end
    respond_to do |format|
      if @dependent_model.update_attributes(params[:dependent_model])
        format.html { redirect_to @dependent_model, notice: 'Dependent model was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @dependent_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dependent_models/1
  # DELETE /dependent_models/1.json
  def destroy
    @dependent_model = DependentModel.find(params[:id])
    @dependent_model.destroy

    respond_to do |format|
      format.html { redirect_to dependent_models_url }
      format.json { head :ok }
    end
  end
end
