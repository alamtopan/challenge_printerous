class Admin < User
  default_scope {where(type: 'Admin')}
end