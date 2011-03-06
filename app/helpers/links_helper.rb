module LinksHelper
  def votecount(link)
    Vote.sum(:total, :conditions => ['link_id = ?', link.id])
  end
  
  def votecast(link)
    @vote = Vote.where("votes.link_id = ? AND votes.email = ?", link.id, current_user.email).first
    if @vote.nil?
      return 0
    else
      return @vote.total
    end
  end
  
  def getthumbimage(type, link)
    votecast_result = votecast(link)
    if (type == "up" && votecast_result == 1)
      return "thumbs" + type + "cast.gif"
    elsif (type == "down" && votecast_result == -1) 
      return "thumbs" + type + "cast.gif"
    else
      return "thumbs" + type + ".gif"
    end
  end
  
  def getthumbtext(type, link)
    votecast_result = votecast(link)
    if (type == "up" && votecast_result == 1)
      return "You voted for this link"
    elsif (type == "down" && votecast_result == -1) 
      return "You voted against this link"
    elsif (type == "up" && votecast_result <= 0) 
      return "Vote for this link"
    elsif (type == "down" && votecast_result >= 0) 
      return "Vote against this link"
    end
  end
end
