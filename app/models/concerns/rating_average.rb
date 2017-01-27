module RatingAverage
  extend ActiveSupport::Concern
    
  def average_rating
    # eka tomiva versio:
    # scores_array = ratings.map {|x| x.score}
    # scores_array.inject(0.0) {|sum, s| sum + s} / ratings.count
    # ja lyhempi versio:
    # ratings.to_a.inject(0.0) {|sum, el| sum + el.score} /ratings.count
    ratings.average(:score)
  end    
    
end