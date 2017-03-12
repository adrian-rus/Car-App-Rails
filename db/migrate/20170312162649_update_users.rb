class UpdateUsers < ActiveRecord::Migration
  def change
    @u = User.find_by( email: 'admin@mail.com' )
    # if there is no user with the email admin@email.ie
    # in the users table the above find_by() method will return nil
    # nil shows there is no record in the table with that email
    if @u != nil
      @u.update_attribute :admin, true
    end
  end
end
