class User < ActiveRecord::Base
  after_create :assign_default_role

  # creatable_by?(user)などのメソッドが利用できるようになる。
  include Authority::Abilities

  # can_create?(resource)などのメソッドが利用できるようになる。
  include Authority::UserAbilities

  # 権限の設定は、/app/authorizers/user_authorizer.rbを参照する
  # self.authorizer_name = 'UserAuthorizer'

  # roleを適用したいmodelの中に記載
  resourcify

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def assign_default_role
    self.add_role(:editor)
  end
end
