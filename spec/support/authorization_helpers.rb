module AuthorizationHelpers
  def sign_in(user)
    session[:user_id] = user.id 
  end

  def define_permission!(user, action, thing)
    Permission.create!(user: user,
                       action: action,
                       thing: thing)
  end

  def check_permission_box(permission, object) 
    check "permissions_#{object.id}_#{permission}"
  end
end

RSpec.configure do |c|
  c.include AuthorizationHelpers
end