class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

# 지금 누가 로그인 했는지 보는것
  def current_user
  	@user ||= User.find(session[:user_id]) if User.exists? && session[:user_id] 
  end

  helper_method :current_user

  def authenticate_user
# false일때 문장 실행
# login을 하지 않았으면 login페이지로 넘어가
  	unless current_user
  		flash[:notice] = "로그인 해야 게시판을 볼 수 있습니다."
  		redirect_to '/user/login'
  	end
  end
end
