class FailController < ApplicationController
  def fail
    raise 'fail'
  end
end
