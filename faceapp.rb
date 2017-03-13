# faceapp.rb
require 'rubygems'
require 'bundler'
Bundler.require
require 'sinatra'

# Load up all our secrets
Dotenv.load

# Set up our AWS authentication for all calls in this app
Aws.config.update({
        :region => 'us-east-1',
        :credentials => Aws::Credentials.new(ENV['AWS_KEY'],ENV['AWS_SECRET'])
    })

# Default collection name
FACE_COLLECTION = "faceapp_test"

# The routes
get '/' do
  # Show the main index page
  erb :faceapp
end


post '/upload/:photoid' do
  client = Aws::Rekognition::Client.new()
  response = client.index_faces({
    collection_id: FACE_COLLECTION,
    external_image_id: params[:photoid],
    image: {
      bytes: request.body.read.to_s
    }
  })
  puts response.to_h
  "Image uploaded safely!"
end


post '/compare' do
  content_type :json
  client = Aws::Rekognition::Client.new()
  response = client.search_faces_by_image({
    collection_id: FACE_COLLECTION,
    max_faces: 1,
    face_match_threshold: 95,
    image: {
      bytes: request.body.read.to_s
    }
  })
  puts response.to_h
  if response.face_matches.count > 1
    {:message => "Too many faces found"}.to_json
  elsif response.face_matches.count == 0
    {:message => "No face detected!"}.to_json
  else
    # "Comparison finished - detected #{ response.face_matches[0].face.external_image_id } with #{ response.face_matches[0].face.confidence } accuracy."
    {:id => response.face_matches[0].face.external_image_id, :confidence => response.face_matches[0].face.confidence, :message => "Face found!"}.to_json
  end
end


post '/speech' do
  client = Aws::Polly::Client.new()
  response = client.synthesize_speech({
    output_format: "mp3",
    voice_id: "Joanna",
    text: params[:tosay]
  })
  puts response.to_h
  Base64.encode64(response.audio_stream.string)
end


get '/collection/:action' do
  client = Aws::Rekognition::Client.new()
  collections = client.list_collections({}).collection_ids
  case params[:action]
    when 'create'
      if !(collections.include? FACE_COLLECTION)
        response = client.create_collection({ collection_id: FACE_COLLECTION })
      end
    when 'delete'
      if (collections.include? FACE_COLLECTION)
        response = client.delete_collection({ collection_id: FACE_COLLECTION })
      end
  end
  redirect '/'
end