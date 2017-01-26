require "sinatra"
require "sinatra/reloader" if development?
require "sqlite3"
require "better_errors"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

DB = SQLite3::Database.new('lib/db/jukebox.sqlite')

get "/" do
  # TODO: Gather all artists to be displayed on home page
  erb :home # Will render views/home.erb file (embedded in layout.erb)
end

get "/artist" do
  # TODO: Gather all artists to be displayed on home page
  erb :artist # Will render views/home.erb file (embedded in layout.erb)
end

get "/album" do
  # TODO: Gather all artists to be displayed on home page
  erb :album # Will render views/home.erb file (embedded in layout.erb)
end

get "/track" do
  # TODO: Gather all artists to be displayed on home page
  erb :track # Will render views/home.erb file (embedded in layout.erb)
end

# Then:
# 1. Create an artist page with all the albums. Display genres as well
# 2. Create an album pages with all the tracks
# 3. Create a track page, and embed a Youtube video (you might need to hit Youtube API)