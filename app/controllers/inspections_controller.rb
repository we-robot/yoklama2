class InspectionsController < ApplicationController
  before_action :set_inspection, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @inspections = Inspection.all
    respond_with(@inspections)
  end

  def show
    respond_with(@inspection)
  end

  def new
    @inspection = Inspection.new
    respond_with(@inspection)
  end

  def edit
  end

  def create
    redirect_to select_week_path(inspection_params[:lesson_id])
  end

  def update
    @inspection.update(inspection_params)
    respond_with(@inspection)
  end

  def destroy
    @inspection.destroy
    respond_with(@inspection)
  end
  def yoklama
    @temp = Inspection.new(inspection_params)
    @temp.lesson_id = params[:lesson_id]
    if params[:inspection][:lesson_type] == "Uygulama"
      @temp.uygulama!
      @temp.hour = params[:inspection][:uygulama_saati]

    elsif params[:inspection][:lesson_type] == "Teorik"
      @temp.teorik!
      @temp.hour = params[:inspection][:teorik_saat]

    end
    lesson_type = @temp.teorik? ? 1 : 0                # 0 ise uygulama - 1 ise teorik
    @yoklama = Inspection.where(lesson_id: @temp.lesson_id, lesson_type: lesson_type, hour: @temp.hour, week: @temp.week)
    if @yoklama.empty?
      @temp.save!
      redirect_to fotograf_cek_path(@temp.id)
    else
      redirect_to inspection_path(@yoklama.first.id)
    end
  end
  def select_week
    @inspection = Inspection.new(lesson_id: params['lesson_id'])
    @teorik     = @inspection.lesson.teorik_saat
    @uygulama   = @inspection.lesson.uygulama_saati
  end
  def tani
    puts params
    render json: { sonuc: "Tanıdı" }
  end
  def fotograf_cek
    @inspection = Inspection.new()
  end
  private
    def set_inspection
      @inspection = Inspection.find(params[:id])
    end

    def inspection_params
      params.require(:inspection).permit(:lesson_id, :week)
    end
end
