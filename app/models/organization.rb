# frozen_string_literal: true

class Organization < ApplicationRecord
  enum org_type: {
    animals: "animals",
    community: "community",
    education: "education",
    environment: "environment",
    health: "health",
    human_rights: "human_rights",
    human_services: "human_services",
    international: "international",
    religion: "religion"
  }

  has_many :donations, dependent: :destroy
end
