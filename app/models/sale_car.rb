class SaleCar < ActiveRecord::Base
	has_many :sale_car_images

	has_attached_file :attachment,
                      processors: [:watermark],
                      watermark_path: "#{Rails.root}/public/Watermark-images.png",
                      styles: {
                        thumb: {
                          geometry: '350x250>'
                        },
												large: {
                          geometry: '1100x700>'
                        }
                      },
                      default_style: :thumb,
                      url: '/sale_cars/:id/:style/:basename.:extension',
                      convert_options: { all: '-strip -auto-orient -colorspace sRGB' }
    validates_attachment :attachment,
      :presence => true,
      :content_type => { :content_type => %w(image/jpeg image/jpg image/png image/gif) }

    validates :price, numericality: true

    # Get image path or string if nil
    def thumb_image_path
    	begin
      	self.attachment.url(:thumb) ? self.attachment.url(:thumb) : "/public/no-image.png"
      rescue
      	"/public/no-image.png"
      end
    end
end
