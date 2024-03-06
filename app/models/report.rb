# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :mentioning, class_name: 'Mention', foreign_key: 'mentioning_report_id', dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioning_reports, through: :mentioning, source: :mentioned_report

  has_many :mentioned, class_name: 'Mention', foreign_key: 'mentioned_report_id', dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioned_reports, through: :mentioned, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def mentioned_report_ids_in_content
    content.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.map(&:to_i).uniq
  end

  def create_mentions!
    extracted_ids = mentioned_report_ids_in_content
    Mention.where(mentioning_report_id: id).destroy_all
    extracted_ids.each do |extracted_id|
      Mention.create!(mentioning_report_id: id, mentioned_report_id: extracted_id)
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
