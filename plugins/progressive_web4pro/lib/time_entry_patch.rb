module TimeEntryPatch
  def self.included(base)
    base.class_eval do

      validate :validate_spent_on_restrictions

      def validate_spent_on_restrictions
        return unless Setting['plugin_progressive_web4pro']['time_entry_restrictions_enabled']
        return if !spent_on_changed? || User.current.admin?
      
        if spent_on > user.today
          errors.add :spent_on, :invalid_spent_on_date
          return
        end
      
        if project.present?
          roles = User.current.roles_for_project(project)
          allowed_past_days = roles.map do |role|
            Setting.plugin_progressive_web4pro["time_entry_allowed_past_days_#{role.name.downcase}"]
          end
          if !allowed_past_days.include?('any')
            if spent_on < user.today - (allowed_past_days.map(&:to_i).max || 0)
              errors.add :spent_on, :invalid_spent_on_date
            end
          end
        end
      end
    end
  end
end

unless TimeEntry.include? TimeEntryPatch
  TimeEntry.send(:include, TimeEntryPatch)
end
