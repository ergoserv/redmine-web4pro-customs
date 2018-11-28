module SettingsHelperPatch
  def self.included(base)
    base.class_eval do
      def issue_custom_fields_list
        IssueCustomField.all.collect { |field| [field.name, field.id] }
      end
    end
  end
end

unless SettingsHelper.include? SettingsHelperPatch
  SettingsHelper.send(:include, SettingsHelperPatch)
end
