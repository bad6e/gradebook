class StudentsController < ApplicationController
  before_action -> { require_user_type('student?') }
  before_action :verify_user_in_params_matches_current_user
  before_action :set_type
  before_action :set_user_type, only: [:show]

  def show
    @user
  end
end
