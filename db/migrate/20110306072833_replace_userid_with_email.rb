class ReplaceUseridWithEmail < ActiveRecord::Migration
  def self.up
    # Define new columns
    add_column :links, :email, :string
    add_column :votes, :email, :string
    
    Link.reset_column_information
    Vote.reset_column_information
    
    # Set data
    @links = Link.all
    @links.each do |link|
      @user = User.where("users.id = ?", link.user_id).first
      link.email = @user.email
      link.save
    end    
    @votes = Vote.all
    @votes.each do |vote|
      @user = User.where("users.id = ?", vote.user_id).first
      vote.email = @user.email
      vote.save
    end    
    # Remove old columns
    remove_column :links, :user_id
    remove_column :votes, :user_id
  end

  def self.down
    # Redefine old columns
    add_column :links, :user_id, :integer
    add_column :votes, :user_id, :integer
    
    Link.reset_column_information
    Vote.reset_column_information

    # Set data back
    @links = Link.all
    @links.each do |link|
      @user = User.where("users.email = ?", link.email).first
      link.user_id = @user.user_id
      link.save
    end    
    @votes = Vote.all
    @votes.each do |vote|
      @user = User.where("users.email = ?", vote.email).first
      vote.user_id = @user.user_id
      vote.save
    end    
    # Remove new columns
    remove_column :links, :email
    remove_column :votes, :email
  end
end
