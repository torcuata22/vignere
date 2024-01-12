class User < ApplicationRecord
  has_many :vigns, dependent: :destroy
  has_many :caesars, dependent: :destroy
  has_many :bacons, dependent: :destroy
  has_many :xors, dependent: :destroy


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
