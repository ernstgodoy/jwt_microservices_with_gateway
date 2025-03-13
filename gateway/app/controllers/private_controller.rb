class PrivateController < ApplicationController
  include Service1Client
  include Service2Client
  before_action :authorize

  def private
    render json: { message: 'Hello from private gateway' }
  end

  def private_to_service_1
    data = call_service1_endpoint('/service1_endpoint')

    render json: { message: data[:message] }, status: :ok
  rescue ServiceError => e
    render json: { error: e.message }, status: :bad_gateway
  end

  def private_to_service_2
    data = call_service2_endpoint('/service2_endpoint')

    render json: { message: data[:message] }, status: :ok
  rescue ServiceError => e
    render json: { error: e.message }, status: :bad_gateway
  end

  def private_to_service_1_with_service_2
    data = call_service1_endpoint('/service1_endpoint_with_service2_call')

    render json: { message: data[:message] }, status: :ok
  rescue ServiceError => e
    render json: { error: e.message }, status: :bad_gateway
  end
end
