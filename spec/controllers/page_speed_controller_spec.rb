require 'spec_helper'

describe PageSpeedController do

  #Delete these examples and add some real ones
  it "should use PageSpeedController" do
    controller.should be_an_instance_of(PageSpeedController)
  end


  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end
end
