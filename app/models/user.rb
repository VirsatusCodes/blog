class User < ApplicationRecord

    has_secure_password
    before_create :set_default_profile_picture

    has_many :comments
    has_many :articles

    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validate :password_complexity

    private

    def set_default_profile_picture
        self.profile_picture ||= 'default_profile_picture.png'
      end

    def password_complexity
        return if password.blank? || password =~ /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/
        
        errors.add :password, 'Complexity requirement not met. Please use: 1 uppercase, 1 lowercase, 1 digit and 1 special character.'
    end

end
