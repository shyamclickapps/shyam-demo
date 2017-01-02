# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  firstname              :string
#  lastname               :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  authentication_token   :string
#  user_type              :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ActiveRecord::Base
  has_many :galleries
  
   include Elasticsearch::Model
   include Elasticsearch::Model::Callbacks
   has_many :phone_numbers  
   has_many :projects

   # Has many through relation for followers and following
  has_many :following_follows, class_name:  "Follow", foreign_key: "following_id", dependent: :destroy
  has_many :followers, through: :following_follows

  has_many :following_follows, class_name:  "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :following_follows

   # validates :email,uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :email, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

# Generate Authentication Token during Signup and Login Process
  before_create :ensure_authentication_token!
  before_create :check_password!

  #************* Checking Access Token of User  ************************
  scope :authenticate!, -> (auth_token) {where(id: id,authentication_token: auth_token) }
  
  # This is for Comparing Password and Confirm Password
  def check_password!
    if self.password != password_confirmation
      false
    end 
  end

  def ensure_authentication_token!
      self.authentication_token = generate_authentication_token
  end
  def full_name
    "#{firstname} #{lastname}"
  end
  def as_indexed_json(options={})
    as_json(
      only: [:id, :full_name,:email],
      include: [:phone_numbers],
      methods: [:full_name]  
    )
  end
  
  private

    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end
end
