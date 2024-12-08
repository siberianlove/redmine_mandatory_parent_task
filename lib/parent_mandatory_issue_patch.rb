require_dependency 'issue'

module ParentMandatoryIssuePatch
  def self.included(base)
    base.class_eval do
      validate :validate_mandatory_parent, if: -> {
        Rails.logger.info("Validation condition check for issue ##{id || 'new'}: project=#{project&.id}, modules=#{project&.enabled_module_names}")
        project&.enabled_module_names&.include?('mandatory_parent_task')
      }

      def validate_mandatory_parent
        Rails.logger.info("Validation: Checking mandatory parent for issue ##{id || 'new'} in project #{project&.name}")
        Rails.logger.info("Validation: #{self}")

        if parent_issue_id.present?
          Rails.logger.info("Validation passed: Parent issue is present.")
          return
        end

        if User.current.allowed_to?(:ignore_mandatory_parent, project)
          Rails.logger.info("Validation bypassed: User #{User.current.login} has ignore permission.")
          return
        end

        Rails.logger.info("Validation failed: Adding error for missing parent issue.")
        errors.add(:parent_issue_id, l(:redmine_mandatory_parent_task_field_required))
      end
    end
  end
end