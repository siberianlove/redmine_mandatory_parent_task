class AddMandatoryParentModule < ActiveRecord::Migration[6.1]
  def up
    EnabledModule.where(name: 'mandatory_parent_task').destroy_all
  end

  def down
    # Откат изменений, если необходимо
  end
end
