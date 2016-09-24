# == Schema Information
#
# Table name: organizations
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_organizations_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_7b93e0061c  (user_id => users.id)
#

class Organization < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "user_id"

  validates_presence_of :name
  validates_presence_of :description

  has_many :events

  after_initialize :set_default_user, :if => :new_record?

  protected
  def set_default_user
    self.owner ||= User.admin.first
  end
end
