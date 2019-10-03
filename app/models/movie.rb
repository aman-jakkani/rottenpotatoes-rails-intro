class Movie < ActiveRecord::Base

    def self.all_ratings
        ['G','PG','PG-13','R','NC-17'].map{|n| n}
    end

    def self.with_ratings(ratingfilters)
        where({rating: ratingfilters})
    end
    
end
