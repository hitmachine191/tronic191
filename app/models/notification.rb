class Notification < ActiveRecord::Base
  belongs_to :notifiable, polymorphic: true
  belongs_to :user
  
end
