class Story < ActiveRecord::Base
  has_many :story_comments
  belongs_to :user

  STATUS = {
    0 => 'new',
    1 => 'started',
    2 => 'finished',
    3 => 'accepted',
    4 => 'rejected'
  }

  def getStatus
    STATUS[@status]
  end
end