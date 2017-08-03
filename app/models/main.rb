
class Main < ApplicationRecord

  validates :name, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9_\-\.]*\z/ }

end