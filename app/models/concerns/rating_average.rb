module RatingAverage
  extend ActiveSupport::Concern
    
  def average_rating
    # seuraavat oman oppimisen takia erilaisia vaihtoehtoja
    # huom. ekoissa mättää sittenkin 0:lla jakaminen
    # eka tomiva versio:
    # scores_array = ratings.map {|x| x.score}
    # scores_array.inject(0.0) {|sum, s| sum + s} / ratings.count
    # ja lyhempi versio:
    # ratings.to_a.inject(0.0) {|sum, el| sum + el.score} /ratings.count
    # tai aineiston esimerkissä:
    # return 0 if ratings.empty?
    # ratings.map {|r| r.score }.sum / ratings.count.to_f
    if ratings.count == 0
      return 0
    else
      ratings.average(:score)
    end    
  end   

end