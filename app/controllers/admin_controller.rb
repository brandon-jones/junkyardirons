class AdminController < ApplicationController
  before_filter :authenticated_admin?
  
  def index

  end
end
