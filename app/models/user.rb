<<<<<<< HEAD
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(60)       default(""), not null
#  user_type              :string(10)
#  role                   :string(30)
#  active                 :boolean          default(TRUE)
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
=======
# ## Schema Information
#
# Table name: `users`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`email`**                   | `string(60)`       | `default(""), not null`
# **`user_type`**               | `string(10)`       |
# **`role`**                    | `string(30)`       |
# **`active`**                  | `boolean`          | `default(TRUE)`
# **`encrypted_password`**      | `string(255)`      | `default(""), not null`
# **`reset_password_token`**    | `string(255)`      |
# **`reset_password_sent_at`**  | `datetime`         |
# **`remember_created_at`**     | `datetime`         |
# **`sign_in_count`**           | `integer`          | `default(0), not null`
# **`current_sign_in_at`**      | `datetime`         |
# **`last_sign_in_at`**         | `datetime`         |
# **`current_sign_in_ip`**      | `string(255)`      |
# **`last_sign_in_ip`**         | `string(255)`      |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
#
# ### Indexes
#
# * `index_users_on_email` (_unique_):
#     * **`email`**
# * `index_users_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
#

class User < ActiveRecord::Base
  include Modules::DefaultValues

<<<<<<< HEAD
  scope :most_active, order("sign_in_count desc")

=======
>>>>>>> ccede0020a94bfc95d0b555b99297784cd882d81
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_type, :role, :active
  # attr_accessible :title, :body

  has_one :student
  has_one :employee
  has_many :follow_ups
  has_many :notifications
  has_many :votes
  has_many :replies

  def admin?
    self.role == "#{User::ADMIN}"
  end
  
  def head_of_department?
    self.role == "#{User::MANAGER}"
  end
  
  def staff?
    self.role == "#{User::STAFF}"
  end
  
  def advisor?
    self.role == "#{User::ADVISOR}"
  end
  
  def student?
    self.role == "#{User::STUDENT}"
  end

  def unread_notifications
    self.notifications.select do |n|
      !n.is_read? && self.id != n.activity.owner_id
    end
  end

end
