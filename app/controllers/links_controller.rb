class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in

  # GET /links
  # GET /links.json
  def index
    @links = Link
             .includes(:tags, :domain, :user)
             .order(created_at: :desc)
             .where(user_id: current_user.id)
             .page(params[:page])
             .load
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
    set_tag_s
    @link.url = params[:url]
    @link.title = params[:title]
  end

  # GET /links/1/edit
  def edit
    set_tag_s
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(link_params)
    update_tags(params[:link][:tags])
    @link.user = current_user
    create_and_respond(@link)
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    result = @link.update(link_params)
    update_tags(params[:link][:tags]) if result
    create_response(result, @link, 'updated', @link, 'edit')
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    domain = @link.domain
    result = @link.destroy
    if result
      update_tags('')
      domain.link_count -= 1 if domain && !domain.destroyed?
    end
    create_response(result, @link, 'destroyed', links_url, links_url)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
    check_for_permission(@link)
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def link_params
    params.require(:link).permit(:title, :url, :description)
  end

  def update_tags(tagstring)
    return if tagstring.nil?
    old_tags = @link.tags
    new_tags = []
    tagstring.split(', ').each do |t|
      new_tags << tag(t)
    end
    @link.tags = []
    @link.tags = new_tags
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
    tag = Tag.where('lower(name) = ?', name.downcase).find_by(user_id: current_user.id)
    if tag.nil?
      tag = Tag.create name: name, tag_type: 'default', user_id: current_user.id
    end
    tag
  end

  def set_tag_s
    @tag_s = @link.tags.map(&:name).to_sentence(last_word_connector: ', ', two_words_connector: ', ')
  end

end
