class Clickbait < ActiveModel::Validator
  def validate(record)
    if record.title
      unless ["Won't Believe", "Secret", "Top [number]", "Guess"].any? { |t| record.title.include? t }
        record.errors[:title] << 'the title does not contain the words'
      end
    end
  end
end

class Post < ActiveRecord::Base
  include ActiveModel::Validations

  validates :title, presence: true
  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: { in: %w(Fiction Non-Fiction)}
  validates_with Clickbait

end
