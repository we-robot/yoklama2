require "FaceRecognition"

class InspectionsController < ApplicationController
  before_action :set_inspection, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @inspections = Inspection.all
    respond_with(@inspections)
  end

  def show
    @students = @inspection.students
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
    rates = student_nos[1]
    taninmayan = student_nos.last
    student_nos = student_nos.first
    @ogrenciler = []
    student_nos.each_with_index do |e, index|
      student = Student.find_by(number: e.to_i)
      student.rate = rates[index] * 100 unless student.nil?
      @ogrenciler << student unless student.nil?
    end

    begin
      @inspection.image.attach(io: File.open("/home/alperen/Desktop/tanima/result.jpg"), filename: 'test.jpg', content_type: 'image/jpeg')
    rescue
      puts "hata çıktı önemsiz"
    end
    render json: { image: url_for(@inspection.image), students: @ogrenciler, taninmayan: taninmayan }
  end

  def yoklama_kaydet
    @inspection = Inspection.find(params[:inspection_id])
    unless params['students'].empty?
      student_ids = params['students'].split(',')
      student_ids.each do |student_id|
        student = Student.find(student_id)
        @inspection.students << student
      end
    end
    @inspection.save!
    flash[:success] = "Öğrenciler Başarıyla yoklamaya Eklendi"
    redirect_to inspection_path(@inspection.id)
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
