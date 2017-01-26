require "sinatra"
require "sinatra/reloader" if development?
require "sqlite3"

DB = SQLite3::Database.new('lib/db/jukebox.sqlite')

get "/" do
  @artists = DB.execute("SELECT name, id FROM artists")
  @artists.map! do |artist|
    artist = {
      name: artist[0],
      id: artist[1]
    }
  end
  erb :home
end


get "/artists/:id" do
  @artist_parameter = params[:id]
  @artist = DB.execute("
    SELECT *
    FROM artists
    JOIN albums ON albums.artist_id = artists.id
    WHERE artists.id = '#{@artist_parameter}'
    ")
  @artist.map! do |album|
    album = {
      creator: album[1],
      id: album[2],
      title: album[3]
    }
  end
  erb :artist
end



get "/albums/:id" do
  @album_parameter = params[:id]
  @album = DB.execute("
    SELECT *
    FROM albums
    JOIN tracks ON tracks.album_id = albums.id
    WHERE albums.id = '#{@album_parameter}'
    ")
  @album.map! do |track|
    track = {
      creator: track[1],
      id: track[0],
      title: track[7]
    }
    #p "$"*100
    #p @album
  end
  erb :album
end

get "/tracks/:id" do
    @track_parameter = params[:id]
    @track = DB.execute("SELECT * FROM tracks WHERE id = '#{@track_parameter}'")
    @track = {
      creator: @track[0][5],
      id: @track[0][0],
      title: @track[0][4]
    }

  erb :track
end

# Then:
# 1. Create an artist page with all the albums. Display genres as well
# 2. Create an album pages with all the tracks
# 3. Create a track page, and embed a Youtube video (you might need to hit Youtube API)
