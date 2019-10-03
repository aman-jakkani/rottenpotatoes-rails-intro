class Movie < ActiveRecord::Base
    attr_accessor :all_ratings
    
    def all_ratings
        @all_ratings = ['G','PG','PG-13','R','NC-17']
    end
    
end
