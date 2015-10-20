# Homepage (Root path)
get '/' do
  erb :index
end

get '/soundtrack' do
  @soundtrack = Song.all
  erb :'songs/index'
end
