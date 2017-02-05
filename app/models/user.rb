class User < ActiveRecord::Base
    include RatingAverage

    has_secure_password

    validates :username, uniqueness: true,
                         length: { minimum: 3, maximum: 30 }
    validates :password, length: {minimum: 4},
                         format: { with: /\A(?=.*[A-Z])(?=.*\d).+\z/ }


    has_many :ratings, dependent: :destroy
end
