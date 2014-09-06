class Link < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  include PgSearch

  attr_accessor :tagstring

  pg_search_scope :search,
                  against: [:title, :url, :description],
                  associated_against: {
                    tags: :name
                  },
                  using: {
                    tsearch: {
                      dictionary: 'english',
                      any_word: true
                    },
                    dmetaphone: {
                      any_word: true,
                      only: [:title, :url, :name]
                    }
                  },
                  ranked_by: ':tsearch + (0.5 * :dmetaphone)'

  has_many :link_tags
  has_many :tags, through: :link_tags, dependent: :destroy
  belongs_to :user
  belongs_to :domain
  validates_presence_of :url
  validates :url, format: /\Ahttp.*\..*\z/

  before_save :check_title
  before_save :associate_with_domain
  before_save :update_tags
  after_destroy :clean_domains
  after_destroy :clean_tags

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

  def clean_domains
    domain.destroy if domain && domain.links.count.zero?
    domain.link_count -= 1 if domain && !domain.destroyed?
  end

  def associate_with_domain
    domain_s = URI.parse(url).host.gsub(/^www\./, '')
    domain = Domain.find_by domain: domain_s, user_id: user_id
    domain = Domain.create domain: domain_s, user_id: user_id if domain.nil?
    self.domain = domain
    domain.link_count += 1
    domain.save
  end

  def update_tags
    return if tagstring.nil?
    old_tags = tags
    new_tags = []
    tagstring.split(', ').each do |t|
      new_tags << tag(t)
    end
    self.tags = []
    self.tags = new_tags
    update_tag_link_counts(old_tags)
    update_tag_link_counts(new_tags)
  end

  def update_tag_link_counts(tags)
    tags.each do |t|
      t.link_count = t.links.count
      t.save
    end
  end

  def tag(name)
    tag = Tag.where('lower(name) = ?', name.downcase).find_by(user_id: user_id)
    if tag.nil?
      tag = Tag.create name: name, tag_type: 'default', user_id: user_id
    end
    tag
  end

  def clean_tags
    update_tag_link_counts(tags)
  end
end
