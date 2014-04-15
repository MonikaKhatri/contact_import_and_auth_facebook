class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def client
    @client ||= FBGraph::Client.new(:client_id => "625181867552254",
      :secret_id => "4b8c8ca2ff216d1fab8a9b4037686d1a" ,
      :token => session[:access_token])
  end
end
