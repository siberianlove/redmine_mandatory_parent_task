require_dependency 'issue'
require_relative 'lib/parent_mandatory_issue_patch'
Issue.send(:include, ParentMandatoryIssuePatch) unless Issue.included_modules.include?(ParentMandatoryIssuePatch)

Redmine::Plugin.register :redmine_mandatory_parent_task do
  name 'Mandatory Parent Task Plugin'
  author 'Viktor Rybakov'
  description 'Плагин для обязательности поля "Родительская задача" в определённых проектах'
  version '0.1.0'

  # Регистрация модуля проекта
  project_module :mandatory_parent_task do
    permission :ignore_mandatory_parent, { parent_mandatory: [:ignore_check] }, require: :member
  end
end

