require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test "all required columns are supplied" do
    link = Link.new
    assert !link.save, "Should not have been able to save a link without a url and a title"
    
    # Add URL and try again:
    link.url = 'http://www.blahblah.com/'
    assert !link.save, "Should not have been able to save a link without a title"
    
    # Add Title and try again:
    link.title = 'Test Title'
    assert link.save, "Should have been able to save the link"
  end
end
