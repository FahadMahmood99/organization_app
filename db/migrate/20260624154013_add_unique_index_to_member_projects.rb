class AddUniqueIndexToMemberProjects < ActiveRecord::Migration[8.1]
  def change
        add_index :member_projects,
              [:member_id, :project_id],
              unique: true
  end
end
