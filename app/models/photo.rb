class Photo < ActiveRecord::Base

	#dragonfly_accessor :image

	validates :title, presence: true, length: {minimum: 2, maximum: 20}
	validates :image, presence: true
	 
	validates :image, presence: true
	validates_size_of :image, maximum: 500.kilobytes,
	                  message: "should be no more than 5 KB", if: :image_changed?
	 
	validates_property :format, of: :image, in: [:jpeg, :png, :bmp], case_sensitive: false,
	                   message: "should be either .jpeg, .png, .bmp", if: :image_changed?

	validates_property :width, of: :image, in: (0..400),
                           message: proc{ |actual, model| "Unlucky #{model.title} - was #{actual}" }



	# Convert the uploded image
	dragonfly_accessor :image do
	  after_assign do |img|
	   img.encode!('bmp', '-quality 80') if img.image?
	  end
	end

	# Rotate the uploaded image
	dragonfly_accessor :image do
	  after_assign do |img|
	   img.rotate!(90) # 90 is the amount of degrees to rotate
	  end
	end

 # Rotate the uploded image using custom method
 # dragonfly_accessor :image do
 #    after_assign :rotate_it
 #  end

 #  def rotate_it
 #    image.rotate!(90)
 #  end

end