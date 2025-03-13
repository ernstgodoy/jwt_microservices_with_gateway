class MyController < ApplicationController
  before_action :authorize

  def service2_endpoint
    render json: { message: "Hello from service 2" }, status: :ok
  end
end
