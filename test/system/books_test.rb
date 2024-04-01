# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:ruby)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
    assert_text 'ログインしました。'
  end

  test 'visiting the index' do
    visit books_url
    assert_selector 'h1', text: '本の一覧'
  end

  test 'should create book' do
    visit books_url
    click_on '本の新規作成'

    fill_in 'タイトル', with: '達人プログラマー'
    fill_in 'メモ', with: '面白いです！'
    click_on '登録する'

    assert_text '本が作成されました。'
    assert_text '達人プログラマー'
    assert_text '面白いです！'
  end

  test 'should update Book' do
    visit book_url(@book)
    click_on 'この本を編集'

    fill_in 'タイトル', with: 'パーフェクトRuby on Rails'
    fill_in 'メモ', with: 'わかりやすかった！'
    click_on '更新する'

    assert_text '本が更新されました'
    assert_text 'パーフェクトRuby on Rails'
    assert_text 'わかりやすかった！'
  end

  test 'should destroy Book' do
    visit book_url(@book)
    click_on 'この本を削除'

    assert_text '本が削除されました'
  end
end
