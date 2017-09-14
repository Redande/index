class Domain < ActiveRecord::Base
  include Timestamped
  extend Gettable

  has_many :links
  belongs_to :user
asd
  validates :name, presence: true
end
