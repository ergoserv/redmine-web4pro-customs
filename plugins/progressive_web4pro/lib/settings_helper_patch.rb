module SettingsHelperPatch
  def issue_custom_fields_list
    IssueCustomField.all.collect { |field| [field.name, field.id] }
  end
end

require 'settings_helper'
SettingsHelper.send :include, SettingsHelperPatch
