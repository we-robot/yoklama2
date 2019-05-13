require "FaceRecognition"

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
    @inspection = Inspection.new
    if inspection_params[:lesson_id].empty?
      flash[:error] = "Ders Seçmediniz."
      render :new
    else
      redirect_to select_week_path(inspection_params[:lesson_id])
    end
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
    @inspection = Inspection.find(params[:inspection_id])

    puts params.keys
    dataURL = params[:image]

    start = dataURL.index(',') + 1                   # .index used here
    x = Base64.decode64 dataURL[start..-1]
    File.open('test.png','wb') do |file|
      file.write x
    end
    begin
      @inspection.image.attach(io: File.open("test.png"), filename: 'test.png', content_type: 'image/png')
    rescue
      puts "hata çıktı önemsiz"
    end

    @inspection.save!

    active_storage_disk_service = ActiveStorage::Service::DiskService.new(root: Rails.root.to_s + '/storage/')
    student_nos = FaceRecognition.identify(active_storage_disk_service.send(:path_for, @inspection.image.blob.key))

    student_nos = student_nos.first
    @ogrenciler = []
    student_nos.each do |e|
      @ogrenciler << Students.find_by(number: e)
    end
    efewefewf
    render json: { image: url_for(@inspection.image), students: @ogrenciler }
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
