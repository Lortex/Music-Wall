# Homepage (Root path)
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

#form to a new account
get '/signup' do
  erb :'signup'
end

#create a new account
post '/signup' do
  @user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password]
  )
  if @user.save
    redirect '/songs'
  else
    erb :'signup'
  end
end

#create a new song
post '/songs' do
  @song = Song.new(
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
    
