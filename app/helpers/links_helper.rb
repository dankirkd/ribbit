module LinksHelper
  def votecount(link)
    Vote.joins(:link).where('votes.link_id' => link.id).count
  end
end
