require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe StoriesController do
  before(:each) do
    controller.stub!(:logged_in?).and_return(true)
  end

  # This should return the minimal set of attributes required to create a valid
  # Story. As you add validations to Story, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { :name => 'Test task' }
  end

  describe "GET index" do
    it "assigns active stories as @stories" do
      story = Story.create! valid_attributes
      get :index
      assigns(:stories).should eq([story])
    end

    it "assigns backlog stories as @stories" do
      story = Story.create! valid_attributes.merge({ :active => false })
      get :index
      assigns(:backlog_stories).should eq([story])
    end
  end

  describe "GET show" do
    it "assigns the requested story as @story" do
      story = Story.create! valid_attributes
      get :show, :id => story.id
      assigns(:story).should eq(story)
    end
  end

  describe "GET new" do
    it "assigns a new story as @story" do
      get :new
      assigns(:story).should be_a_new(Story)
    end
  end

  describe "GET edit" do
    it "assigns the requested story as @story" do
      story = Story.create! valid_attributes
      get :edit, :id => story.id
      assigns(:story).should eq(story)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Story" do
        expect {
          post :create, :story => valid_attributes
        }.to change(Story, :count).by(1)
      end

      it "assigns a newly created story as @story" do
        post :create, :story => valid_attributes
        assigns(:story).should be_a(Story)
        assigns(:story).should be_persisted
      end

      it "redirects to the created story" do
        post :create, :story => valid_attributes
        response.should redirect_to(Story.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved story as @story" do
        # Trigger the behavior that occurs when invalid params are submitted
        Story.any_instance.stub(:save).and_return(false)
        post :create, :story => {}
        assigns(:story).should be_a_new(Story)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Story.any_instance.stub(:save).and_return(false)
        post :create, :story => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested story" do
        story = Story.create! valid_attributes
        # Assuming there are no other stories in the database, this
        # specifies that the Story created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Story.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => story.id, :story => {'these' => 'params'}
      end

      it "assigns the requested story as @story" do
        story = Story.create! valid_attributes
        put :update, :id => story.id, :story => valid_attributes
        assigns(:story).should eq(story)
      end

      it "redirects to the story" do
        story = Story.create! valid_attributes
        put :update, :id => story.id, :story => valid_attributes
        response.should redirect_to(story)
      end
    end

    describe "with invalid params" do
      it "assigns the story as @story" do
        story = Story.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Story.any_instance.stub(:save).and_return(false)
        put :update, :id => story.id, :story => {}
        assigns(:story).should eq(story)
      end

      it "re-renders the 'edit' template" do
        story = Story.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Story.any_instance.stub(:save).and_return(false)
        put :update, :id => story.id, :story => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested story" do
      story = Story.create! valid_attributes
      expect {
        delete :destroy, :id => story.id
      }.to change(Story, :count).by(-1)
    end

    it "redirects to the stories list" do
      story = Story.create! valid_attributes
      delete :destroy, :id => story.id
      response.should redirect_to(stories_url)
    end
  end

  describe "POST update status" do
    before(:each) do
      @story = Story.create! valid_attributes
      user = User.create!({ :username => 'test', :salt => '', :password => 'test' })
      @story.user = user
    end

    #it "changes Story's state" do
    #  post :update_status, :id => @story.id, :event => "accept"
    #  assigns(:story).accepted?.should be_true
    #end

    it "redirects to the story" do
      post :update_status, :id => @story.id, :event => "accept"
      response.should redirect_to(@story)
    end
  end

  describe "GET move" do
    it "moves story to backlog" do
      story = Story.create! valid_attributes
      story.active.should be_true
      get :move, :id => story.id
      assigns(:story).active.should be_false
    end

    it "redirects to the story" do
      story = Story.create! valid_attributes
      get :move, :id => story.id
      response.should redirect_to(story)
    end
  end

  describe "GET history" do
    it "assigns finished stories as @stories" do
      story = Story.create! valid_attributes.merge({:status => "finished", :finished_at => Time.zone.now.yesterday })
      get :history
      assigns(:stories).should eq([story])
    end
  end
end
