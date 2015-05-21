module RequestHelpers
  include Warden::Test::Helpers
  
  def sign_in_as(user = FactoryGirl.create(:user))
    @user ||= user
    login_as @user
  end
end
