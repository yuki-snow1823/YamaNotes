# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Memos', type: :system, js: true do
  before do
    user = FactoryBot.create(:user)
    sign_in user
    start_walk
    visit walk_path
  end

  it 'メモを追加する' do
    add_memo
    expect(page).to have_content('到着記録を更新しました')
    visit arrivals_path
    expect(page).to have_content('新しいメモ')
  end

  it 'メモを編集できる' do
    add_memo
    visit arrivals_path
    edit_memo
    expect(page).to have_content('編集済みのメモ')
    expect(page).not_to have_content('新しいメモ')
  end

  it 'メモにリンクを貼る' do
    url1 = 'https://x.com/suzuka_hori'
    url2 = 'https://github.com/users/SuzukaHori/projects/4'
    add_memo("#{url1}と#{url2}をつなげます")
    visit arrivals_path
    expect(page).to have_link(url1)
    click_on url2
    switch_to_window(windows.last)
    expect(page).to have_title('Backlog · YamaNotes')
  end

  private

  def add_memo(text = '新しいメモ')
    click_on 'memo_modal_button'
    fill_in 'arrival_memo', with: text
    click_on '保存'
  end

  def edit_memo
    click_on '編集'
    fill_in 'arrival_memo', with: '編集済みのメモ'
    click_on '保存'
  end
end
