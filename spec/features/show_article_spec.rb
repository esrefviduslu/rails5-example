require 'rails_helper'

RSpec.feature "Showing an article" do
  
  before do
    @john = User.create(email: "john@example.com", password: "12341234")
    @fred = User.create(email: "fred@example.com", password: "12341234")
    @article = Article.create(title: "The first article", body: "Lorem ipsum dolor sit amet, consectetur.", user: @john)
  end
  
  scenario "to non-signed in user hide the Delete and Edit buttons" do
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
  
  scenario "to non-owner hide the Delete and Edit buttons" do
    login_as(@fred)
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
  
  scenario "A signed owner sees both the Delete and Edit buttons" do
    login_as(@john)
    visit "/"
    click_link @article.title
    
    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    
    expect(page).to have_link("Edit Article")
    expect(page).to have_link("Delete Article")
  end
end