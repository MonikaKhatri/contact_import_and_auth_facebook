class FbAuthenticationController < ApplicationController
  include Devise::Controllers::Helpers
  def start
   redirect_to client.authorization.authorize_url(:redirect_uri => "http://#{request.env['HTTP_HOST']}/fb_oauth/callback/" ,
      :client_id => 625181867552254, :scope => 'email')
  end

  def callback
    @access_token = client.authorization.process_callback(params[:code], :redirect_uri => "http://#{request.env['HTTP_HOST']}/fb_oauth/callback/")
    session[:access_token] = @access_token
    @fb_user = client.selection.me.info!
    logger.warn("===========#{@fb_user}.inspect")
    @user = User.new
    old = User.find_by(email: @fb_user.email)
    if old.present?
      old.destroy
    end
    @user.email = @fb_user.email
    @user.fb_id = @fb_user.id
    @user.name = "#{@fb_user.first_name} #{@fb_user.last_name}"
    @user.fb_token = @access_token
    @user.save(:validate => false)
    @picture = client.fql.query("SELECT pic FROM user WHERE uid = #{@fb_user.id}").data.data.first
    session[:user_id] = @user.id
    sign_in @user, :bypass => true
  end
end