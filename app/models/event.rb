# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  title            :string
#  begin_at         :date
#  end_at           :date
#  enroll_beigin_at :datetime
#  enroll_end_at    :datetime
#  latitude         :float
#  longitude        :float
#  city             :string
#  description      :text
#  cover            :string
#  logo             :string
#  organization_id  :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_events_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_163b5130b5  (organization_id => organizations.id)
#

class Event < ApplicationRecord
  belongs_to :organization
  mount_uploader :cover, PhotoUploader
  mount_uploader :logo, PhotoUploader

  validates_presence_of :title
  validates_presence_of :begin_at
  validates_presence_of :end_at
  validates_presence_of :enroll_beigin_at
  validates_presence_of :enroll_end_at
  validates_presence_of :city
  validates_presence_of :description
  validates_presence_of :cover
  validates_presence_of :logo
  validates_presence_of :organization_id

  validate :date_should_be_right

  def date_should_be_right
    if begin_at > end_at
      errors.add(:begin_at, "can't be in the past of end at")
    end
    if enroll_beigin_at > begin_at
      errors.add(:enroll_beigin_at, "can't be in the past of begin_at")
    end
    if enroll_beigin_at > enroll_end_at
      errors.add(:enroll_beigin_at, "can't be in the past of enroll_end_at")
    end
    if begin_at < Date.today
      errors.add(:begin_at, "can't be in the past")
    end
  end

  def status
    if Time.now < enroll_beigin_at
      return "working"
    elsif Time.now > enroll_beigin_at and Time.now <= enroll_end_at
      return "enroll"
    elsif  Time.now > enroll_end_at and Time.now < begin_at
      return "before"
    elsif  Time.now >= begin_at and Time.now <= end_at
      return "ongoing"
    else
      return "end"
    end
  end
end
