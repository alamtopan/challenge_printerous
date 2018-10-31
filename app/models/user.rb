class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :latest, -> {order(created_at: :desc)}
  scope :oldest, -> {order(created_at: :asc)}

  def is_admin?
    self.type == "Admin"
  end

  def is_account_manager?
    self.type == "AccountManager"
  end
end
