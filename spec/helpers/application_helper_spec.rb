require 'rails_helper'

describe ApplicationHelper do
  describe 'Basic Helper Functionality' do
    context 'On any page' do
      it 'Returns the correct titles' do
        expect(full_title).to eql('Android: Netrunner Cards and Deckbuilder')
        expect(full_title('Help')).to eql('Help | NetrunnerDB')
      end
    end
  end
end
