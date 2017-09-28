class CvController < Sinatra::Base

	configure :development do
		register Sinatra::Reloader
	end

	set :root, File.join(File.dirname(__FILE__), "..")

	set :views, Proc.new { File.join(root, 'views') }

  $posts = [{
      title: "Example job",
      year: "January 2015 - January 2016",
      body: "Example job description"
  },
  {
      title: "Example job",
      year: "January 2014 - January 2015",
      body: "Example job description"
  },
  {
      title: "Example job",
      year: "January 2014 - January 2015",
      body: "Example job description"
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
































