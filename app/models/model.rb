class Model < ActiveRecord::Base
	validates :name, presence: true
	belongs_to :brand
end
