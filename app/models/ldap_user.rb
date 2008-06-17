class LdapUser < ActiveLdap::Base
  ldap_mapping :dn_attribute => "uid", :prefix => "c=us,ou=bluepages,o=ibm.com"
  # ldap_mapping :dn_attribute => "uid", :prefix => "ou=bluepages"

  # belongs_to :manager, :class => 'LdapUser', :foreign_key => 'manager', :primary_key => 'dn'
  # belongs_to :manager, :class => 'LdapUser'
  has_many   :manages, :class => 'LdapUser', :foreign_key => 'dn', :primary_key => 'manager'
 
  def self.authenticate_from_email(email, password)
    return nil unless (u = find(:attribute => "mail", :value => email))
    begin
      dn = u.dn.gsub(/\+/, "\\\\+")
      logger.debug("authenticate_from_email #{email} => #{dn}")
      u.connection.rebind(:allow_anonymous => false, :password => password, :bind_dn => dn)
    rescue
      logger.debug("authenticate_from_email denied")
      nil
    end
  end

  private

  def to_real_attribute_name(name, allow_normalized_name=nil)
    allow_normalized_name = true if allow_normalized_name.nil?
    super(name, allow_normalized_name)
  end
end
