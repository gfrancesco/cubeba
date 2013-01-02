require "rubygems"
require "bundler/setup"

# require your gems as usual

require 'sinatra'
require 'haml'
require 'rack'
require 'pony'

#set :environment, :production
#set :port, 80

helpers do

  def protected!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', 'sergiopaolo']
  end

end

get '/' do
  haml :index
end

get '/food' do
  haml :food
end

get '/drink' do
  haml :drink
end

get '/dance' do
  haml :dance
end

get '/news' do
  haml :news
end

get '/contatti' do
  haml :contatti
end

get '/chi_siamo' do
  haml :chi_siamo
end

get '/galleria' do
  haml :galleria
end

get '/newsletter' do
  haml :newsletter
end

get '/privacy' do
  haml :privacy
end

post '/newsletter' do
  name = params[:firstname]
  surname = params[:surname]
  town = params[:town]
  email = params[:email]
  age = params[:age]
  pr = params[:privacy]
  if pr == 'on'
    @privacy = 'Dati inviati con successo'
    Pony.mail(:to => 'info@cubeba.it', :subject => '[cubeba] Nuova iscrizione utente',
            :body => "Nome: #{name}\n Cognome: #{surname}\n Eta': #{age}\n Paese: #{town}\n Email: #{email}\n", :via => :smtp, :via_options => {
  :address              => 'smtp.gmail.com',
  :port                 => '587',
  :enable_starttls_auto => true,
  :user_name            => 'cubebapress',
  :password             => 'cubita83',
  :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
  :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
  })

  else
    @privacy = 'Dati non inviati, consenso al trattamento dei dati non selezionato'
  end
  
  
  haml :newsletter
end


get '/admin' do
  protected!
  @title = params[:title]
  haml :admin
end

post '/admin' do
  protected!
  c = params[:content]
  t = params[:title]
  if t.empty?
    "Non hai inserito il titolo (o data) della news! <br> <a href='/admin'>Torna alle news</a>"
  else
    body c
    Dir.mkdir(File.join("public", "news", t)) if !File.directory?(File.join("public", "news", t))
    File.open(File.join("public", "news", t, "text.html"), "w") { |f| f.write c }
    "Testo news creato. Ricordati di caricare il flyer (nome file: flyer.jpg, dimensione: 150 x 210 px) via ftp nella cartella 'news/" + t + "' <br> <a href='/admin'>Torna alle news</a>"
  end
end

post '/*.html' do |filename|
  send_file 'public/galleria/' + filename + '/_ajax.html'
end
