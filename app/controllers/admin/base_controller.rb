class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :require_super_admin, :except => 'user_sessions#create'
end
