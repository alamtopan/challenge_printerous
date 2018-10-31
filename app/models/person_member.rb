class PersonMember < ApplicationRecord
  belongs_to :organization, optional:true

  scope :latest, -> {order(created_at: :desc)}
  scope :oldest, -> {order(created_at: :asc)}
  scope :bonds, ->{joins(:organization)}

  mount_uploader :avatar, ImageUploader

  def self.by_keywords(_key)
    return if _key.blank?
    query_opts = [
      "LOWER(organizations.name) LIKE LOWER(:key)",
      "LOWER(person_members.email) LIKE LOWER(:key)",
      "LOWER(person_members.phone) LIKE LOWER(:key)",
      "LOWER(person_members.name) LIKE LOWER(:key)"
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
