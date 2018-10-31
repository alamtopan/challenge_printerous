class Organization < ApplicationRecord
  belongs_to :account_manager, optional: true
  has_many :person_members, dependent: :destroy

  scope :latest, -> {order(created_at: :desc)}
  scope :oldest, -> {order(created_at: :asc)}
  scope :bonds, ->{joins(:account_manager)}

  mount_uploader :logo, ImageUploader

  def self.by_keywords(_key)
    return if _key.blank?
    query_opts = [
      "LOWER(organizations.name) LIKE LOWER(:key)",
      "LOWER(organizations.email) LIKE LOWER(:key)",
      "LOWER(organizations.phone) LIKE LOWER(:key)",
      "LOWER(organizations.website) LIKE LOWER(:key)",
      "LOWER(users.email) LIKE LOWER(:key)"
    ].join(' OR ')
    where(query_opts, {key: "%#{_key}%"} )
  end

  def self.search_by(options={})
    results = bonds

    if options[:key].present?
      results = results.by_keywords(options[:key])
    end

    return results
  end
end
