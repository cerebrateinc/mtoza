class CreateKickstarterProjects < ActiveRecord::Migration
  def change
    create_table :kickstarter_projects do |t|
      t.timestamps
      t.integer :uid
      t.string  :name
      t.string  :goal
      t.string  :pledged
      t.string  :state
      t.string  :country
      t.string  :creator
      t.datetime  :deadline
      t.datetime  :project_launched_at
      t.datetime :project_created_at
      t.integer :backers_count
      t.string  :location_str
      t.string  :category_str
    end
  end
end
