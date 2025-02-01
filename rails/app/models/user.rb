# frozen_string_literal: true

class User < ApplicationRecord
  # extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  # dependent: :destory→親レコードであるusers側が削除された場合に、子レコードであるarticlesも一緒に削除するオプション
  has_many :articles, dependent: :destroy
end
