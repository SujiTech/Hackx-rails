# == Schema Information
#
# Table name: authorizations
#
#  id         :integer          not null, primary key
#  provider   :string           not null
#  uid        :string(1000)     not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_authorizations_on_provider_and_uid  (provider,uid)
#  index_authorizations_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_4ecef5b8c5  (user_id => users.id)
#

class Authorization < ApplicationRecord
  belongs_to :user
end
