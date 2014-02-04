# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(20)       default(""), not null
#  user_type              :string(10)
#  role                   :string(30)
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
#

class User < ActiveRecord::Base
  include Modules::DefaultValues
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

end
