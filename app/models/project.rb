# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  name        :string
#  team_name   :string
#  tags        :string           is an Array
#  description :text
#  prize       :hstore
#  event_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_projects_on_event_id  (event_id)
#  index_projects_on_tags      (tags)
#
# Foreign Keys
#
#  fk_rails_24f8faf2dc  (event_id => events.id)
#

class Project < ApplicationRecord
end
