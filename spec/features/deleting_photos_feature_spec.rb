require 'rails_helper'

feature 'Photos' do

  context 'deleting posts' do

    it 'signed in user can delete a post' do
      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: "test@hotmail.com"
      fill_in 'Password', with: "123456"
      fill_in 'Password confirmation', with: "123456"
      click_button 'Sign up'
      expect(page).to(have_content("No photos yet"))
      click_link 'Add post'
      page.attach_file 'photo_image', "spec/images/toffee.jpg"
      fill_in 'Caption', with: 'Amazing doggie #toffee'
      click_button 'Create Photo'
      expect(page).to have_css "img[src*='toffee.jpg']"
      click_link "Delete photo"
      expect(page).to(have_content('Photo deleted successfully'))
      expect(page).not_to(have_css "img[src*='toffee.jpg']")
    end

    it 'logged out user cannot delete a post' do
      visit '/'
      expect(page).not_to(have_link('Delete photo'))
    end
  end
end