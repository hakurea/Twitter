class UserController < ApplicationController
  def new
  end

  def create
    @email = params[:email]
    @password = params[:password]

    User.create(email: @email, password: @password)
    redirect_to '/'
  end

  def login
  end

  def login_process
    @email = params[:email]
    @password = params[:password]

    user = User.find_by(email: @email)

    #user가 있는지부터 먼저 검사
    if User.exists?(email: @email)
      # 아이디와 패스워드 일치 하면 로그인
      if user.password == @password
        session[:user_id] = user.id
        #로그인 성공
        flash[:green] = "#{@email}님, 어서옵쇼"
        redirect_to '/'

      else
        #비밀번호가 틀렸음
        flash[:notice] = "비밀번호가 틀렸습니다. 확인해 주세요"
        redirect_to '/user/login'
      end

    else
      #user 정보가 없음
      flash[:notice] = "너 누구야?!!"
      redirect_to '/user/new'
    end
    # 일치하지 않으면 너 아이디가 없어!!
  end

  def logout
    session.clear
    flash[:notice] = "로그아웃 되었습니다."
    redirect_to '/'
  end
end
