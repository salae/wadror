class User < ActiveRecord::Base
    include RatingAverage

    has_secure_password

    validates :username, uniqueness: true,
                         length: { minimum: 3, maximum: 30 }
    validates :password, length: {minimum: 4},
                         format: { with: /\A(?=.*[A-Z])(?=.*\d).+\z/ }


    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_many :memberships, dependent: :destroy
    has_many :beer_clubs, through: :memberships

    def favorite_beer
        return nil if ratings.empty?
        # vaihtoehtoisia tapoja, käytössä optimiratkaisu
        # ratings.sort_by{ |r| r.score }.last.beer 
        # ratings.sort_by(&:score).last.beer
        ratings.order(score: :desc).limit(1).first.beer
    end
end
