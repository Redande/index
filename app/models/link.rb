class Link < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  has_many :link_tags
  has_many :tags, through: :link_tags, dependent: :destroy
  belongs_to :user
  belongs_to :domain, dependent: :destroy
  validates_presence_of :url
  validates :url, format: /\Ahttp.*\..*\z/

  before_save :check_title

  def timestamp
    diff = Time.now.to_i - created_at.to_i
    return created_at.strftime('%B %-d %Y') if diff >= 1.year
    return created_at.strftime('%B %-d') if diff >= 1.day
    return time_s(diff, 1.hour, 'hour') if diff >= 1.hour
    return time_s(diff, 1.minute, 'minute') if diff >= 1.minute
    'just now'
  end

  private

  def time_s(diff, divisor, word)
    pluralize(diff / divisor, word) + ' ago'
  end

  def check_title
    self.title = url if title.blank?
  end
end
