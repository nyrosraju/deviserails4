require 'twitter'
class Authorization < ActiveRecord::Base
belongs_to :user

	after_create :fetch_details



	def fetch_details
		self.send("fetch_details_from_#{self.provider.downcase}")
	end


	def fetch_details_from_facebook
		graph = Koala::Facebook::API.new(self.token)
		facebook_data = graph.get_object("me")
		self.username = facebook_data['username']
		self.save
		self.user.username = facebook_data['username'] if self.user.username.blank?
		self.user.remote_image_url = "http://graph.facebook.com/" + self.username + "/picture?type=large" if self.user.image.blank?
		self.user.location = facebook_data['location']['name'] if self.user.location.blank?
		self.user.save
	end

	def fetch_details_from_twitter
		twitter_object = Twitter::Client.new(
			:oauth_token => self.token,
			:oauth_token_secret => self.secret
			)
		puts "sssssssssss#{twitter_object.inspect}"
		
		twitter_data = Twitter.user(self.uid.to_i)
		self.username = twitter_data.username
		self.save
		self.user.username = twitter_data.username if self.user.username.blank?
		self.user.remote_image_url = twitter_data.profile_image_url if self.user.image.blank?
		self.user.location = twitter_data.location if self.user.location.blank?
		self.user.save(:validate => false)
	end


	def fetch_details_from_github
	end


	def fetch_details_from_linkedin

	end

	def fetch_details_from_google_oauth2

	end  
end
