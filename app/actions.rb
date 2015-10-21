# Homepage (Root path)
helpers do

  #checks if any users are logged in
  def logged_in?
    !!current_user
  end

  def current_user
    if cookies[:user_id]
      @current_user = User.find(cookies[:user_id])
    end
  end
end



get '/' do
  erb :index
end

#list of songs on a wall
get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

#form for a new song
get '/songs/new' do
  erb :'songs/new'
end

#login to user
get '/login' do
  erb :'login'
end

get '/logout' do
  cookies.delete :user_id if cookies[:user_id]
  redirect to '/'
end

#form to a new account
get '/signup' do
  erb :'signup'
end

#searches for the user with info given
post '/login' do
  @user = User.find_by(username: params[:username_or_email], password: params[:password] )
  if @user.nil?
    @user = User.find_by(email: params[:username_or_email], password: params[:password])
  end
  if @user
    cookies[:user_id] = @user.id
    redirect to('/')
  else
    @error_messages = ['Invalid user info']
    erb :'login'
  end
end

#create a new account
post '/signup' do
  @user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password]
  )
  if @user.save
    cookies[:user_id] = @user.id
    redirect '/songs'
  else
    erb :'signup'
  end
end

#create a new song
#if else statement allows anonymous OR user-made additions
post '/songs' do
  #make the song as a user if logged in
  if logged_in?
    @song = @current_user.songs.new(
      title: params[:title],
      author: params[:author],
      url: params[:url]
    )
    if @song.save
      redirect '/songs'
    else
      erb :'songs/new'
    end
    #otherwise, make the song anonymously
  else
    @song = @current_user.songs.new(
      title: params[:title],
      author: params[:author],
      url: params[:url]
    )
    if @song.save
      redirect '/songs'
    else
      erb :'songs/new'
    end
  end
end
