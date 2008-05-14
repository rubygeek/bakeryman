require File.dirname(__FILE__) + '/../test_helper'
require 'bakeryorder_controller'

# Re-raise errors caught by the controller.
class BakeryorderController; def rescue_action(e) raise e end; end

class BakeryorderControllerTest < Test::Unit::TestCase
  def setup
    @controller = BakeryorderController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
