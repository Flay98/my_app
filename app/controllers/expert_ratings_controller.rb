class ExpertRatingsController < ApplicationController
  before_action :set_expert_rating, only: %i[ show edit update destroy ]

  # GET /expert_ratings or /expert_ratings.json
  def index
    @expert_ratings = ExpertRating.all
  end

  # GET /expert_ratings/1 or /expert_ratings/1.json
  def show
  end

  # GET /expert_ratings/new
  def new
    @expert_rating = ExpertRating.new
  end

  # GET /expert_ratings/1/edit
  def edit
  end

  # POST /expert_ratings or /expert_ratings.json
  def create
    @expert_rating = ExpertRating.new(expert_rating_params)

    respond_to do |format|
      if @expert_rating.save
        format.html { redirect_to @expert_rating, notice: "Expert rating was successfully created." }
        format.json { render :show, status: :created, location: @expert_rating }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @expert_rating.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /expert_ratings/1 or /expert_ratings/1.json
  def update
    respond_to do |format|
      if @expert_rating.update(expert_rating_params)
        format.html { redirect_to @expert_rating, notice: "Expert rating was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @expert_rating }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @expert_rating.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /expert_ratings/1 or /expert_ratings/1.json
  def destroy
    @expert_rating.destroy!

    respond_to do |format|
      format.html { redirect_to expert_ratings_path, notice: "Expert rating was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expert_rating
      @expert_rating = ExpertRating.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expert_rating_params
      params.require(:expert_rating).permit(:user_id, :image_id, :rating)
    end
end
