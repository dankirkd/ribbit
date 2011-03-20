require 'test_helper'

class VoteTest < ActiveSupport::TestCase
  test "changing a vote" do
    vote = Vote.new
    vote.email = "daniel@kirkdorffer.com"
    vote.link = links(:google)
    assert vote.save, "Should have been able to save the vote."
    assert_equal vote.total, 1, "Vote total should have been 1" 
    
    # Try to change the vote:
    vote.total = -1
    assert vote.save, "Should have been able to save the vote."
    assert_equal vote.total, -1, "Vote total should have been -1" 
  end

  test "uniqueness of vote records" do
    vote = Vote.new
    vote.email = "daniel@kirkdorffer.com"
    vote.link = links(:google)
    assert vote.save, "Should have been able to save the vote."
    
    # Try again with a new vote with the same email address and the same link:
    vote = Vote.new
    vote.email = "daniel@kirkdorffer.com"
    vote.link = links(:google)
    assert !vote.save, "Should not have been able to save the vote."
  end
end
