class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #setting session parameters
    session[:order] = params[:order] unless params[:order].nil?
    session[:ratings] = params[:ratings] unless params[:ratings].nil? || params[:ratings].empty?
    
    #filtering which ratings we need
    ratingsfilters = []
    unless session[:ratings].nil?
      ratingsfilters = session[:ratings].keys
    else
      ratingsfilters = Movie.all_ratings
    end
    
    #getting movies with those ratings and updating checked filters to show view
    @movies = Movie.with_ratings(ratingsfilters).order(session[:order])
    @all_ratings = Movie.all_ratings
    @checked_filters = ratingsfilters
    @sortby = session[:order]
    
    #redirect back with URI params
    redirect_to movies_path order: session[:order], ratings: session[:ratings] if (params[:order].nil? && session[:order]) || (params[:ratings].nil? && session[:ratings])
    
  end
  
  def new
    # default: render 'new' template
  end
  
  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
