#created January 27, 2015 by Christian Seremetis
require "bundler"
Bundler.require


require_relative './models/product.rb'
require_relative './models/review.rb'

set :database, "sqlite3:product.db"
class MyApp < Sinatra::Base

    get '/' do
        #brings user to the home page
        erb :index
    end

    get '/CreateReview' do
        #brings user to the "create review" page
        erb(:CreateReview) 
    end

    get '/ExistingReviews' do
        #allows the user to view all existing reviewed products
        @reviews=Product.all
        erb(:ExistingReviews)
    end

    get '/ReviewTemplate' do
        #this is a page used to display all the reviews for a certain product
        erb(:ReviewTemplate)
    end

    post '/CreateReview' do
        #where the user can add a review
        #reviews are made using input that is received in a textbox
        #the user can review any product, historical figure, concept, service, etc.
        #once their review is submitted, the user will be redirected to the ReviewTemplate page

        @every = []
        #creates an array of all products
        @every = Product.all

        #checks to see if the product already exists
        @every.each do |a|
            if  params[:productName].downcase.strip == a.productName.downcase.strip
                #updates original product review
                @change = Product.where(:productName.downcase => params[:productName].downcase.strip)

                #updates based on radio button input
                case params[:rating]
                when "a"
                   @change[1] += 1
                when "b"
                    @change[2] += 1
                when "c"
                    @change[3]+= 1
                when "d"
                    @change[4] += 1
                when "e"
                    @change[5] += 1
                when "f"
                    @change[6] += 1
                end
                puts @change
                @change.save 
            end
        end
        
        redirect('/ExistingReviews')
    end
 
    post '/UpdateReview' do
        erb(:ReviewTemplate)
    end 

    post '/AddReview' do
        redirect('/CreateReview')
    end

    post '/Defer' do 
        redirect('/CreateReview')
    end
end







