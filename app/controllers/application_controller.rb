class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to "/recipes"
  end

  # loads the index page
  get '/recipes' do
    erb :index
  end
  
  # loads a new form
  get '/recipes/new' do
    erb :new
  end
  
  # creates the new recipe
  post '/recipes' do
    # @recipe = Recipe.create(params)
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end 
  
  get '/recipes/:id/edit' do  #load edit form
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end
 
  patch '/recipes/:id' do #edit action
    @recipes = Recipe.find_by_id(params[:id])
    @recipes = params
    @recipes.save
    redirect to "/recipes/#{@recipe.id}"
  end

  delete '/recipes/:id' do #delete action
    @recipes = Recipe.find_by_id(params[:id])
    @recipes.delete
    redirect to '/recipes'
  end

end
