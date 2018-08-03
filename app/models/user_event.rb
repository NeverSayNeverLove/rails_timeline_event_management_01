class UserEvent < ApplicationRecord
  belongs_to :event, dependent: :destroy
  belongs_to :user
end
