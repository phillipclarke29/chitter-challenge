
require './spec/factories/user'
require './spec/factories/peep'
require 'Timecop'

feature 'Creating Peeps' do

  scenario 'As a user I can add a peep' do
    user = create :user
    peep = create :peep
    sign_in_as(user)
    visit '/peeps/new'
    fill_in 'message', with: 'This is a new peep!'
    click_button 'Peep'
    peep = Peep.first
    expect(peep.message).to eq('This is a new peep!')
  end

  scenario 'As a non-user I cannot add a peep' do
    visit '/peeps/new'
    expect(page).to have_content 'Please login in order to create a Peep'
  end

  scenario 'I would like my name to be added to my peeps' do
    user = create :user
    peep = create :peep
    sign_in_as(user)
    peep_now(peep)
    visit('/')
    expect(page).to have_content('Peeped by pip')
  end

  scenario 'I would like my peep to be dated' do
    user = create :user
    peep = build :peep
    new_time = Time.local(2008, 9, 1, 12, 0, 0)
    Timecop.freeze(new_time)
    sign_in_as(user)
    peep_now(peep)
    visit('/')
    expect(page).to have_content('2008-09-01T12:00:00+01:00')
    Timecop.return
  end

end


def sign_in_as(user)
  visit '/sessions/new'
  fill_in :email,    with: user.email
  fill_in :password, with: user.password
  click_button 'Sign in'
end

def peep_now(peep)
  visit '/peeps/new'
  fill_in :message, with: peep.message
  click_button 'Peep'
end
