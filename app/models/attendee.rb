# == Schema Information
#
# Table name: attendees
#
#  id           :integer          not null, primary key
#  name         :string
#  gender       :integer
#  education    :integer
#  graduation   :boolean
#  birthday     :date
#  school_name  :string
#  email        :string
#  phone_number :string
#  github       :string
#  project_id   :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_attendees_on_email       (email) UNIQUE
#  index_attendees_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_ff09edb360  (project_id => projects.id)
#

class Attendee < ApplicationRecord
  belongs_to :project
end
