class ImagesController < ApplicationController
  before_action :require_sign_in, only: %i[show]
  before_action :require_admin, only: %i[new create edit update destroy]
  before_action :set_image, only: %i[show edit update destroy]

  # GET /images or /images.json
  def index
    @per_page = params[:per_page].presence_in(%w[5 10 15]) || "10"
    @sort = params[:sort].presence_in(%w[id_asc id_desc rating_asc rating_desc]) || "id_asc"

    images_query = Image
                     .left_joins(:expert_ratings)
                     .includes(task: :theme)
                     .select("images.*, AVG(expert_ratings.rating) AS average_rating_value")
                     .group("images.id")

    images_query =
      case @sort
      when "id_desc"
        images_query.order(id: :desc)
      when "rating_asc"
        images_query.order(Arel.sql("AVG(expert_ratings.rating) ASC NULLS LAST"))
      when "rating_desc"
        images_query.order(Arel.sql("AVG(expert_ratings.rating) DESC NULLS LAST"))
      else
        images_query.order(id: :asc)
      end

    @images = images_query.page(params[:page]).per(@per_page)
    @images_total_count = Image.count

    @image_work_indices = {}

    theme_ids = @images.map { |image| image.task&.theme_id }.compact.uniq

    theme_ids.each do |theme_id|
      Image.by_theme(theme_id).order(:id).pluck(:id).each_with_index do |image_id, index|
        @image_work_indices[image_id] = index
      end
    end
  end

  # GET /images/1 or /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images or /images.json
  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: "Image was successfully created." }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @image.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /images/1 or /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: "Image was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @image.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /images/1 or /images/1.json
  def destroy
    @image.destroy!

    respond_to do |format|
      format.html { redirect_to images_path, notice: "Image was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
  def image_params
    params.require(:image).permit(:task_id, :file_name, :description, :photo)
  end
end
