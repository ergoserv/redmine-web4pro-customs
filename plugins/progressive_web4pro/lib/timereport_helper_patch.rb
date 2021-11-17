module TimereportHelperPatch
  def self.included(base)
    base.class_eval do

      def estimated_hours_for_developer(hours_for_value = nil)
        custom_field_id = Setting['plugin_progressive_web4pro']['estimated_developer_time_field']
        collection = hours_for_value ? filtered_issues(hours_for_value) : @issues
        hours = collection.map do |issue|
          issue.custom_field_value(custom_field_id).to_f
        end

        hours.compact.sum
      end

      def filtered_issues(hours_for_value)
        @issues.select { |i| hours_for_value.map { |x| x['issue'].to_i }.uniq.include?(i.id) }
      end

      def progressive_web4pro_active?
        Setting['plugin_progressive_web4pro']['status_progressive_web4pro']
      end

      def progressive_time_entry_restrictions_enabled?
        Setting['plugin_progressive_web4pro']['time_entry_restrictions_enabled']
      end

      def progressive_calendar_for_time_entry_spent_on
        return if progressive_time_entry_restrictions_enabled? && !User.current.admin?

        calendar_for('time_entry_spent_on')
      end
    end
  end
end

unless TimelogHelper.include? TimereportHelperPatch
  TimelogHelper.send(:include, TimereportHelperPatch)
end
