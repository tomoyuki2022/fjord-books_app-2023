# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'should return true when user is editable' do
    alice = users(:alice)
    bob = users(:bob)
    alice_report = reports(:alice_report)
    assert alice_report.editable?(alice)
    assert_not alice_report.editable?(bob)
  end

  test 'should return date without time' do
    report = Report.new(created_at: Time.zone.local(2024, 3, 18))
    assert_equal Date.new(2024, 3, 18), report.created_on
  end

  test 'should save mentions' do
    alice = users(:alice)
    bob = users(:bob)
    carol = users(:carol)

    alice_report = alice.reports.create!(title: 'アリスです', content: 'よろしくお願いします')
    bob_report = bob.reports.create!(title: 'ボブです', content: "http://localhost:3000/reports/#{alice_report.id}")
    carol_report = carol.reports.create!(title: 'キャロルです', content: "http://localhost:3000/reports/#{alice_report.id}\nhttp://localhost:3000/reports/#{alice_report.id}")
    assert_includes bob_report.mentioning_reports, alice_report
    assert_equal 1, carol_report.mentioning_reports.count

    bob_report.update!(content: "http://localhost:3000/reports/#{carol_report.id}")
    bob_report.reload
    assert_includes bob_report.mentioning_reports, carol_report
    assert_not_includes bob_report.mentioning_reports, alice_report
  end
end
