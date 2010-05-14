class User < ActiveRecord::Base
  attr_protected :ldap_id, :admin
  has_one :cmvc
  accepts_nested_attributes_for :cmvc, :allow_destroy => true

  def ldap
    LdapUser::find(:attribute => 'mail', :value => ldap_id)
  end

  def first_name
    @first_name ||= 
      if (given = ldap.givenName).is_a? Array
        given.min { |a, b| a.length <=> b.length }
      else
        given
      end
  end
end
