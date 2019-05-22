require 'redmine'

Redmine::Plugin.register :progressive_web4pro do
  name 'Progressive Web4pro Customs'
  author 'Alex Andreiev @ ErgoServ'
  author_url 'https://www.ergoserv.com'
  description 'Pack of extensions for Web4pro'
  version '1.0.0'
  requires_redmine :version_or_higher => '3.2'
  settings :default => {
    'status_progressive_web4pro' => false,
    'time_entry_restrictions_enabled' => true,
    'estimated_developer_time_field' => ''
  }, :partial => 'settings/progressive_web4pro_settings'
end

require 'settings_helper_patch'
require 'time_entry_patch'
require 'timereport_helper_patch'
