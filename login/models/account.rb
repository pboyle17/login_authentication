class Account < ActiveRecord::Base
  include BCrypt

  #setter for password
  #Account.password='dkfljsdalf;as' is a method call.
  def password=(pwd)
    self.password_digest = BCrypt::Password.create(pwd)
  end

  #getter for password
  def password
    BCrypt::Password.new(self.password_digest)
  end

  #create a method to test if we are allowed authorization
  def self.authenticate(user_name,password)
    current_user=Account.find_by(user_name: user_name)
    #instead of looping
    #return current user if passwords match
    if (current_user.password == password)
      return current_user
    else
      return nil
    end
  end


end
