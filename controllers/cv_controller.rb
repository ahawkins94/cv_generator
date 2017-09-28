class CvController < Sinatra::Base

	configure :development do
		register Sinatra::Reloader
	end

	set :root, File.join(File.dirname(__FILE__), "..")

	set :views, Proc.new { File.join(root, 'views') }

	$posts = [{
		title: "Example job",
		pow: "Example Workplace",
		date: "January 2015 - January 2016",
		body: "Example job description"
  },
  {
    	title: "Example Job Jitle",
    	pow: "Example Workplace",
    	date: "January 2014 - January 2015",
   		body: "Example job description"
  },
  {
    	title: "Example job",
    	pow: "Example Workplace",
    	date: "January 2014 - January 2015",
    	body: "Example job description"
  }]

	$details = [{
  		name: "Joe Blogs",
  		birthday: "dd/mm/yy",
  		profile: "Include about 100 words about yourself here"

  }]

	get '/posts' do
		@work_header = "Work History"
		@posts = $posts
		@details = $details
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
			pow: params[:pow],
			date: params[:date],
			body: params[:body]
		}
		$posts << new_post
		redirect '/posts'
	end

	get "/posts/:id/edit" do
		@id = params[:id].to_i
		@post = $posts[@id]
		@details = $details[@id]

		erb :"posts/edit"
	end

	put "/posts/:id" do
		id = params[:id].to_i
		$posts[id][:title] = params[:title]
		$posts[id][:pow] = params[:pow]
		$posts[id][:date] = params[:date]
		$posts[id][:body] = params[:body]

		redirect "/posts/#{id}"

	end

	delete '/posts/:id' do
		id = params[:id].to_i
		$posts.delete_at(id)
		redirect '/posts'
	end


end
































