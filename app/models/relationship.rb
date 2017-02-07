class Relationship < ApplicationRecord
  belong_to :followed, class_name: User.name
  belong_to :follower, class_name: User.name
end
