class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

=begin
  get '/' do
    #show all recipes & ask if user wants to add a new one
    @recipes = Recipe.all
    erb :index
  end
=end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  post '/recipes' do
    #@recipe = Recipe.create(params)
    @recipe = Recipe.create(:name => params[:name], :ingredients => params[:ingredients], :cook_time => params[:cook_time])
    #@recipe = Recipe.create(name: :params[:name] , ingredients: :params[:ingredients] , cook_time: :params[:cook_time])
    #@recipe.name = params[:name]
    #@recipes.ingredients = params[:ingredients]
    #@recipes.cook_time = params[:cook_time]

    redirect '/recipes/#{@recipe.id}'
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.update(params[:recipe])
    @recipe.save

    redirect '/recipes/#{@recipe.id}'
  end

  delete '/recipes/:id' do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.destroy
    redirect '/recipes'
  end

end
