require 'rails_helper'

RSpec.feature "Adding reviews to Articles" do
  before do
    @john = User.create(email: "john@example.com", password: "12341234")
    @fred = User.create(email: "fred@example.com", password: "12341234")
    @article = Article.create!(title: "Title One", body: "Body of article one", user: @john)  
  end
  
  scenario "permits a signed in user to writea review" do
    login_as(@fred)
    
    visit "/"
    
    click_link @article.title
    fill_in "New Comment", with: "An amazing article"
    click_button "Add comment"
    
    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("An amazing article")
    expect(current_path).to eq(article_path(@article.id))
  end
  
end