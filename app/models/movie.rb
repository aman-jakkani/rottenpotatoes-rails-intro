class Movie < ActiveRecord::Base
    scope :all_ratings, where(all_ratings: ['G','PG','PG-13','R','NC-17'])
    
end
