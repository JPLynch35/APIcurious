class User < ApplicationRecord
  validates_presence_of :provider, :uid, :name, :profile_pic, :token
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.profile_pic = auth.extra.raw_info.avatar_url
      user.token = auth.credentials.token
      user.save!
    end
  end
end
