class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
    #validates :email, :presence => true,:if => "!email.blank?"  
  #serialize :location, Array
 
   before_save :set_dummy_email
   mount_uploader :image, ImageUploader
   has_many :authorizations
   


   
   def self.from_omniauth(auth, current_user)
     "iiiiiiiiiiiiiiiiiiiiiiiiiiiii#{auth.credentials.token} ..................#{auth.credentials.secret}"
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s, :token => auth.credentials.token, :secret => auth.credentials.secret).first_or_initialize
    puts "################################ #{authorization.inspect}"
    if authorization.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth["info"]["email"]).first : current_user
      if user.blank?
        "user balckkkkkkkkkkkkkkkkkkkkk"
       user = User.new
       user.password = Devise.friendly_token[0,10]
       user.username = auth.info.name
       user.email = auth.info.email
       auth.provider == "twitter" ?  user.save(:validate => false) :  user.save!
     end
     authorization.username = auth.info.nickname
     authorization.user_id = user.id
     authorization.save
   end
    puts 'ssssssssssssssssssssssssssssssssssssssss'
   authorization.user
 end
   
 def set_dummy_email
  self.email ||= "#{self.username}-CHANGEME@example.com"
end  
   
   
end
