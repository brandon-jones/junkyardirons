class MachineSet < ActiveRecord::Base
  validates :price, presence: true
  validates :title, presence: true
  validates :quantity, presence: true
  has_many :machines, dependent: :destroy

end