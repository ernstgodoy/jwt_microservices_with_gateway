class MyController < ApplicationController
  include Service2Client
  before_action :authorize

  def service1_endpoint
    render json: { message: "Hello from service 1" }, status: :ok
  end

  def service1_endpoint_with_service2_call
    data = call_service2_endpoint('/service2_endpoint')
    render json: { message: "Hello from service 1 & #{data[:message]}" }, status: :ok

  rescue ServiceError => e
    render json: { error: e.message }, status: e.status
  end
end
