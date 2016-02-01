class ContactsController < ApplicationController
  layout "admin"
  
  def index
    @contacts = Contact.all
    if params[:account_id]
      @contacts.by_account(params[:account_id])
    end
  end
  
  def new
    @contact = Contact.new
    @account_id = params[:account_id]
  end
  
  def create
    @account = Account.find_by(:id => params[:contact][:account_id])
    @contact = Contact.create(:account_id => params[:contact][:account_id], :first_name => params[:contact][:first_name], :last_name => params[:contact][:last_name], :email => params[:contact][:email], :phone => params[:contact][:phone])
  end
  
end