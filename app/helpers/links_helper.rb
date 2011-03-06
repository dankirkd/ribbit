module LinksHelper
  def votecount(link)
    Vote.sum(:total, :conditions => ['link_id = ?', link.id])
  end
end
