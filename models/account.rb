class Account < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    create! do |account|
      account.name     = auth[:info]['name']
      account.uid      = auth['uid']
      account.role     = 'users'
      account.provider = auth['provider']
    end
  end
end
