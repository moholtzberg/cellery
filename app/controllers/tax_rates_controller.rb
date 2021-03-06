class TaxRatesController < ApplicationController
  layout "admin"
  helper_method :sort_column, :sort_direction
  
  def index
    authorize! :read, TaxRate
    @tax_rates = TaxRate.order(sort_column + " " + sort_direction)
    
    unless params[:term].blank?
      @tax_rates = @tax_rates.lookup(params[:term]) if params[:term].present?
    end
    @tax_rates = @tax_rates.paginate(:page => params[:page], :per_page => 100)
    respond_to do |format|
      format.html
      #format.json {render :json => @tax_rates.map {|a| [{id: a.id, label: a.zip_code, value: a.zip_code}]}}
      format.json {render :json => @tax_rates.map(&:zip_code)}
    end
  end
  
  def sort_column
    TaxRate.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end