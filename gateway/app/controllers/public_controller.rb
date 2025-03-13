class PublicController < ApplicationController
  def public
    render json: { message: 'Hello from public gateway' }
  end
end
