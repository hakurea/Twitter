class PostsController < ApplicationController
  before_action :authenticate_user, except: :index

  def new
  end

  def index
  	@posts = Post.all.reverse
  end

  def create
  	@t = params[:title]
  	@c = params[:content]

  	Post.create(title: @t, content: @c)
  	redirect_to '/'
  end

  def show
  	@id = params[:id]
  	@post = Post.find(@id)
  	@post.replies
  end
  
  def destroy
    @id = params[:id]
    @post = Post.find(@id)
    @post.destroy

    redirect_to :back
  end

  def edit
    @id = params[:id]
    @post = Post.find(@id)
  end

  def update
    @id = params[:id]
    @post = Post.find(@id)
    @t = params[:title]
    @c = params[:content]

    @post.update(title: @t, content: @c)
    redirect_to '/'
  end

  def create_reply
    @c = params[:content]
    @id = params[:id]

    Reply.create(content: @c, post_id: @id)
    #  rails 4버전
    redirect_to :back
    # rails 5버전
    # redirect_back(fallback_location: post_path)
  end

  def destroy_reply
    @id = params[:id]
    Reply.destroy(@id)

    redirect_to :back
  end

  def edit_reply
    @id = params[:id]
    @post = Reply.find(@id)

    @edit_re = Reply.find(@id)
    
  end

  def update_reply
    @id = params[:id]
    @c = params[:content]

    @update_re = Reply.find(@id)
    @update_re.post_id
    @update_re.update(content: @c)
    redirect_to "/posts/show/#{@update_re.post_id}"
  end 
end
