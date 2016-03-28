require 'sinatra'
require 'sqlite3'

class Post
  attr_reader :id, :name, :content

  def initialize(id, name, content)
    @id = id
    @name = name
    @content = content
  end
end
DB = SQLite3::Database.open 'test.db'

get '/' do
  @posts = (DB.execute"SELECT name FROM Posts").join(', ')
  erb :index
end

get '/new' do
  erb :new_create
end

post '/new' do
  post = Post.new(params['id'].to_i, params['name'], params['content'])
  if params['name'].size >= 256
    'Sorry, your blog post name is too long'
  else
    DB.execute("INSERT INTO Posts (id, name, content) VALUES(?, ?, ?)",
               [post.id, post.name, post.content])
    post.name
  end
end

get '/:id' do
  row = DB.get_first_row "SELECT * FROM Posts WHERE id = #{params['id'].to_i}"
  if row
    @requested_post = Post.new(row[0], row[1], row[2])
    erb :post_id
  else
    'Requested blog is not present'
  end
end

delete '/:id' do
  DB.execute("DELETE FROM Posts WHERE id = #{params['id'].to_i}")
  redirect to('/')
end

get 'search/:tag' do
  
end


# rails genarate scaffold
# validates :name, presence:true (da ne sa null)