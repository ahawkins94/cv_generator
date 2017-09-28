require 'sinatra'
require 'sinatra/reloader' if development? 

require_relative './controllers/cv_controller.rb'

use Rack::MethodOverride

run CvController