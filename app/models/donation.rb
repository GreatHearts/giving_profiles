# frozen_string_literal: true

class Donation < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  validates_numericality_of :amount, greater_than: 0

  def self.all_newest_first
    Donation.all.sort_by(&:created_at)
  end
end
