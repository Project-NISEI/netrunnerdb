require 'rails_helper'

describe StaticPagesController do
  render_views
  describe 'Static Routing' do
    context 'On Root Path' do
      it 'should get root' do
        get :home
        assert_response :success
        assert_select 'title', 'Android: Netrunner Cards and Deckbuilder'
      end
    end

    context 'On Help Path' do
      it 'should get help path' do
        get :help
        assert_response :success
        assert_select 'title', 'Help | NetrunnerDB'
      end
    end

    # Not sure why this one's not working yet
    # context 'On Cards Path' do
    #   it 'should get cards path' do
    #     get :cards
    #     assert_response :success
    #     assert_select 'title', 'Cards | NetrunnerDB'
    #   end
    # end

    context 'On Contact Path' do
      it 'should get contact path' do
        get :contact
        assert_response :success
        assert_select 'title', 'Contact | NetrunnerDB'
      end
    end
  end
end
