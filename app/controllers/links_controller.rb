class LinksController < ApplicationController
  include LinksHelper

  # GET /links
  # GET /links.xml
  def index
    @links = Link.all.sort { |linka,linkb| votecount(linkb) <=> votecount(linka) }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @links }
    end
  end

  # GET /links/new
  # GET /links/new.xml
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @link }
    end
  end

  # GET /links/1/edit
  def edit
    @link = Link.find(params[:id])
  end

  # POST /links
  # POST /links.xml
  def create
    @link = Link.new(params[:link])
    @link.user = current_user
    @vote = Vote.new
    @vote.link = @link
    @vote.user = current_user

    respond_to do |format|
      if @link.save
        @vote.save
        format.html { redirect_to(links_url, :notice => 'Link was successfully created.') }
        format.xml  { render :xml => @link, :status => :created, :location => @link }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to(links_url, :notice => 'Link was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @link.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.xml
  def destroy
    @link = Link.find(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to(links_url) }
      format.xml  { head :ok }
    end
  end

  # PUT /links/1/upvote
  def upvote
    # Rails.logger.info("current_user: #{current_user}")
  
    @link = Link.find(params[:id])
    @user = User.find(current_user.id)
    @vote = Vote.new
    @vote.link = @link
    # Rails.logger.info("current_user: #{@current_user.inspect}")
    # Rails.logger.info("user: #{@user.inspect}")
    @vote.user = @user
    # Rails.logger.info("vote: #{@vote.inspect}")

    respond_to do |format|
      if @vote.save
        format.html { redirect_to(links_url, :notice => 'Your vote was successfully recorded.') }
      else
        format.html { redirect_to(links_url, :notice => 'Your vote was not recorded.') }
      end
    end
  end

  # PUT /links/1/downvote
  def downvote
    @link = Link.find(params[:id])
    @vote = Vote.new
    @vote.link = @link
    @vote.user = current_user

    respond_to do |format|
      if @vote.save
        format.html { redirect_to(links_url, :notice => 'Your vote was successfully recorded.') }
      else
        format.html { redirect_to(links_url, :notice => 'Your vote was not recorded.') }
      end
    end
  end
end
