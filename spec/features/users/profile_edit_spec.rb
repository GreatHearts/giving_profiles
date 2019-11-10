require 'rails_helper'

feature 'User profile edit', js: true do
  let!(:user1) { FactoryBot.create(:user_with_fav_orgs) }

  scenario 'valid changes' do
    login_as(user1, :scope => :user)
    visit edit_user_path(user1)
    fill_in 'user_first_name', with: 'Mia'
    fill_in 'user_last_name', with: 'Okoye'
    fill_in 'user_email', with: 'mokoye@gmail.com'
    fill_in 'user_philosophy', with: 'Anything worth doing, is worth doing well.'
    fill_in 'user_user_favorite_organizations_attributes_0_description', with: 'New favorite organization description.'
    click_button 'Save Profile'

    within(".profile-flash__container") do 
      expect(page).to have_content "Successfully saved profile changes!"
    end

    within(".mini-user-profile-info") do
      expect(page).to have_content "Mia Okoye"
    end

    within('.profile-section[data-title="philosophy"]') do
      expect(page).to have_content "Anything worth doing, is worth doing well."
    end

    expect(page).to have_css(".fav-org__description", text: "New favorite organization description.")
  end

  scenario 'invalid changes' do
    login_as(user1, :scope => :user)

    visit edit_user_path(user1)
    fill_in 'user_first_name', with: ''
    fill_in 'user_last_name', with: ''
    click_button 'Save Profile'
    within(".profile-flash__container") do 
      expect(page).to have_content "First name can't be blank"
      expect(page).to have_content "Last name can't be blank"
    end
  end
end
