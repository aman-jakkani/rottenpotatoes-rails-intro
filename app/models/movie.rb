class Movie < ActiveRecord::Base

    def self.all_ratings
        ['G','PG','PG-13','R','NC-17']
    end
    
    def self.with_ratings(ratingfilter)
        self.where({rating: ratingfilter})
    end
    
end
