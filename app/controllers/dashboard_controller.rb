# frozen_string_literal: true

class DashboardController < ApplicationController
  def index
    unless logged_in?
      redirect_to registrations_index_path
    end

    @files = UserResource.all
    @categories = Tag.all

    return unless params.key?('id')

    @called_file = UserResource.find params[:id]
    @user_name = User.find(@called_file.user_id).username

    return if @called_file.file.filename.nil?

    @file_of_current_resource = @called_file.file
  end
end
