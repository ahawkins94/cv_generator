class CvController < Sinatra::Base

	configure :development do
		register Sinatra::Reloader
	end

	set :root, File.join(File.dirname(__FILE__), "..")

	set :views, Proc.new { File.join(root, 'views') }

  $posts = [{
      title: "Post 1",
      body: "This is the first post"
  },
  {
      title: "Post 2",
      body: "This is the second post"
  },
  {
      title: "Post 3",
      body: "This is the third post"
  }]

	get '/posts' do
		@page_header = "All the posts"
		@posts = $posts
		erb :"posts/index"
	end

	get '/posts/new' do
		erb :"posts/new"
	end

	get '/posts/:id' do
		id = params[:id].to_i
		@page_header = "Post #{id+1}"
		@post = $posts[id]
		erb :"posts/shows"	
	end

	post "/posts" do
		new_post = {
			title: params[:title],
			body: params[:body]
		}
		$posts << new_post
		redirect '/posts'
	end

	get "/posts/:id/edit" do
		@id = params[:id].to_i
		@post = $posts[@id]

		erb :"posts/edit"
	end

	put "/posts/:id" do
		id = params[:id].to_i
		$posts[id][:title] = params[:title]
		$posts[id][:body] = params[:body]

		redirect "/posts/#{id}"

	end

	delete '/posts/:id' do
		id = params[:id].to_i
		$posts.delete_at(id)
		redirect '/posts'
	end


end
































