module ApplicationHelper
  # Returns the full title of a given page
  def full_title(page_title = '')
    if page_title.empty?
      'Android: Netrunner Cards and Deckbuilder'
    else
      page_title + ' | NetrunnerDB'
    end
  end
end
