class Task < ActiveRecord::Base
  validates_presence_of :uid, :value, :last_update

end
