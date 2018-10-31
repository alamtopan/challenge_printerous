class AccountManager < User
  default_scope {where(type: 'AccountManager')}
  has_many :organizations, dependent: :destroy
  
  def self.by_keywords(_key)
    return if _key.blank?
    query_opts = [
      "LOWER(users.email) LIKE LOWER(:key)"
    ].join(' OR ')
    where(query_opts, {key: "%#{_key}%"} )
  end

  def self.search_by(options={})
    results = latest

    if options[:key].present?
      results = results.by_keywords(options[:key])
    end

    return results
  end
end