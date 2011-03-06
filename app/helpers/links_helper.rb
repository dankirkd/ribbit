module LinksHelper
  def votecount(link)
    Vote.joins(:link).where('votes.link_id' => link.id).sum('votes.total')
  end
end
