class FailController < ApplicationController
  skip_before_action :require_login

  def fail
    raise 'fail'
  end
end
