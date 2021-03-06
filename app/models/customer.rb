class Customer < ActiveRecord::Base
	validate :first_or_last
	# validates :phone, uniqueness: true, scope: :first_name
	# validates :email, uniqueness: true

	before_save :generate_name
	before_save :format_phone

	has_many :contacts, :dependent => :destroy

	# Remove non-digit characters from phone number
	def format_phone
		if self.phone.present?
			self.phone = self.phone.gsub(/\D/, "")
		end
	end

	def generate_name
		my_first_name = self.first_name.present? ? self.first_name : ""
		my_last_name = self.last_name.present? ? self.last_name : ""
		both = (!my_first_name.empty? && !my_last_name.empty?) ? " " : ""
		self.full_name = my_first_name + both + my_last_name
	end

	def first_or_last
		if !first_name? && !last_name?
			errors.add(:base, "Specify first name, last name, or both")
		end
	end

end
