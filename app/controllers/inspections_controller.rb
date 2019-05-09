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
    @inspection = Inspection.new(inspection_params)
    @inspection.save
    respond_with(@inspection)
  end

  def update
    @inspection.update(inspection_params)
    respond_with(@inspection)
  end

  def destroy
    @inspection.destroy
    respond_with(@inspection)
  end

  def select_week
    
  end

  private
    def set_inspection
      @inspection = Inspection.find(params[:id])
    end

    def inspection_params
      params.require(:inspection).permit(:lesson_id)
    end
end
