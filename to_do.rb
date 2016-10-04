require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/cross_origin'
require 'sinatra/json'
require './models/user'
require './models/item'
require 'json'

set :database, "sqlite3:to_do.sqlite3"

configure do
  enable :cross_origin
end

get '/hi' do
  puts 'Hi there!'
  { 'greeting' => 'Hi there!' }.to_json
end

get '/foo' do
  json :foo => 'bar'
end

post '/users' do
  first_name = params['first_name']
  last_name  = params['last_name']

  user = User.create!(first_name: first_name, last_name: last_name)

  status 200
  json :user => user
end

get '/users/:id' do
  id = params[:id]

  user = User.find(id)

  status 200
  json :user => user
end

post '/items' do
  description = params['description']
  due_at      = params['due_at']
  user_id     = params['user_id']

  item = Item.create!(
    description: description,
    due_at:      due_at,
    completed:   false,
    user_id:     user_id
  )

  status 200
  json :item => item
end

get '/items/incomplete' do
  user_id = params['user_id']

  items = Item.where(user_id: user_id, completed: false)

  status 200
  json :items => items
end

put '/items/:id/complete' do
  id = params[:id]

  item = Item.find(id)
  item.update_attribute(:completed, true)

  status 200
  json :item => item
end
