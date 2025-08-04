class Message < ApplicationRecord
  belongs_to :user
  
  validates :content, presence: true, length: { minimum: 1, maximum: 1000 }
  
  scope :recent_messages, -> { order(created_at: :asc).limit(50) }
  scope :chronological, -> { order(created_at: :asc) }
  
  def formatted_time
    created_at.strftime("%H:%M")
  end
  
  def formatted_date
    created_at.strftime("%B %d, %Y at %H:%M")
  end
end
