class MediumImportsController < ApplicationController
  def new
    @medium_import = MediumImport.new
  end

  def create
    @medium_import = MediumImport.new(params[:medium_import])
    if @medium_import.save
      redirect_to media_path, notice: "Imported media successfully."
    else
      render :new
    end
  end

end
