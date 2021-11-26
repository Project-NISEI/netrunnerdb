require 'rails_helper'

describe UsersController do
  before(:each) do
    user = FactoryBot.create(:user)
    sign_in user
  end

  render_views

  context 'while logged in' do
    it 'should have a current user' do
      expect(subject.current_user).to_not eq(nil)
    end

    it 'should show user name' do
      get :show, params: { id: subject.current_user.id }
      expect(response).to have_http_status(200)
      expect(response.body).to include(subject.current_user.name)
    end
  end
end
