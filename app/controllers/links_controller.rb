class LinksController < ApplicationController
  include LinksHelper

  # GET /links
  # GET /links.xml
  def index
    @links = Link.all.sort { |linka,linkb| votecount(linkb) <=> votecount(linka) }

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /links/new
  # GET /links/new.xml
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
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
    @link.email = current_user.email
    @vote = Vote.new
    @vote.link = @link
    @vote.email = current_user.email

    respond_to do |format|
      if @link.save
        @vote.save
        format.html { redirect_to(links_url, :notice => "The link entitled '" + @link.title + "' was successfully added.") }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /links/1
  # PUT /links/1.xml
  def update
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        format.html { redirect_to(links_url, :notice => "The link entitled '" + @link.title + "' was successfully updated.") }
      else
        format.html { render :action => "edit" }
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
    end
  end

  # PUT /links/1/upvote
  def upvote
    # Rails.logger.info("current_user: #{current_user.inspect}")
    
    # Find previously existing vote (if any)
    @vote = Vote.where("votes.link_id = ? AND votes.email = ?", params[:id], current_user.email).first
    Rails.logger.info("Looking to alter: #{@vote.inspect}")
    
    message = ""
    @link = Link.find(params[:id])
    if @vote.nil?
      @user = User.find(current_user.id)
      @vote = Vote.new
      @vote.errors.clear
      @vote.link = @link
      @vote.email = @user.email
      # Note default value for @vote.total is 1
    else
      # If already +1
      if @vote.total == 1 
        message = "You've already voted for the link entitled '" + @link.title  + "'."
      else
        @vote.total = 1
      end
    end
    
    respond_to do |format|
      if @vote.invalid? 
        Rails.logger.info("error: #{@vote.errors[:email][0]}")
        message = @vote.errors[:email][0]
      else 
        if message == ""
          if @vote.save
            message = "Your vote for the link entitled '" + @link.title  + "' was successfully recorded."
          else
            message = "Your vote for the link entitled '" + @link.title  + "' was not recorded."
          end
        end
      end
      format.html { redirect_to(links_url, :notice => message ) }
    end
  end

  # PUT /links/1/downvote
  def downvote
    # Rails.logger.info("current_user: #{current_user.inspect}")
    
    # Find previously existing vote (if any)
    @vote = Vote.where("votes.link_id = ? AND votes.email = ?", params[:id], current_user.email).first
    Rails.logger.info("Looking to alter: #{@vote.inspect}")
    
    message = ""
    @link = Link.find(params[:id])
    if @vote.nil?
      @user = User.find(current_user.id)
      @vote = Vote.new
      @vote.errors.clear
      @vote.link = @link
      @vote.email = @user.email
    end
    # If already -1
    if @vote.total == -1 
      message = "You've already voted against the link entitled '" + @link.title  + "'."
    else
      @vote.total = -1
    end
    
    respond_to do |format|
      if message == ""
        if @vote.save
          message = "Your vote against the link entitled '" + @link.title  + "' was successfully recorded."
        else
          message = "Your vote against the link entitled '" + @link.title  + "' was not recorded."
        end
      end
      format.html { redirect_to(links_url, :notice => message ) }
    end
  end
end
