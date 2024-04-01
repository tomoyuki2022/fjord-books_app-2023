# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:alice_report)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
    assert_text 'ログインしました。'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: '初めての日報'
    fill_in '内容', with: 'よろしくお願い致します。'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text '初めての日報'
    assert_text 'よろしくお願い致します。'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in 'タイトル', with: '日報の修正'
    fill_in '内容', with: '日報を修正しました。'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '日報の修正'
    assert_text '日報を修正しました。'
  end

  test 'should destroy Report' do
    visit report_url(@report)
    click_on 'この日報を削除'

    assert_text '日報が削除されました'
  end
end
