class Post < ApplicationRecord

    # is expected to validate that :title cannot be empty/falsy
    validates :title, presence: true

    # is expected to validate that the length of :content is at least 250
    validates :content, length: { minimum: 250 }

    # is expected to validate that the length of :summary is at most 250
    validates :summary, length: { maximum: 250 }

    # is expected to validate that :category is either ‹"Fiction"› or ‹"Non-Fiction"›
    validates :category, inclusion: { in: ['Fiction', 'Non-Fiction'] }


    # is expected to allow :title to be ‹"You Won't Believe These True Facts"›
    # is expected not to allow :title to be ‹"True Facts"›
    # validate will call a custom method
    validate :clickbait?

    # you make an array of click bait patters
    CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top \d/i,
    /Guess/i
    ]

    # make a function that goes through the array and if the title matches it is considered clickbait
    def clickbait?
        if CLICKBAIT_PATTERNS.none? { |pat| pat.match title }
          errors.add(:title, "must be clickbait")
        end
    end
end