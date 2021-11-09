class Movie < ActiveRecord::Base
    def self.all_ratings
      ['G', 'PG', 'PG-13', 'R']
    end
    
    def self.with_ratings(ratings, sort_by)
      if ratings.nil?
        all.order sort_by
      else
        where(rating: ratings.map(&:upcase)).order sort_by
      end
    end
  
    def self.find_in_tmdb(search_terms)
      if !search_terms[:title] then
        Faraday.get(search_terms)
      end
      query = "https://api.themoviedb.org/search/movie?api_key=c4ce88d789ecd2caad42a13cba8642d5&query=" + search_terms[:title]
      if search_terms["release_year"] then
        query += "&year=" + search_terms[:release_year]
      end
      if search_terms["language"] then
        query += "&language=" + search_terms[:language]
      end
      Faraday.get(URI.escape(query))
    end
  
end
  