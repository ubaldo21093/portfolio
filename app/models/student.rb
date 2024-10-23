class Student < ApplicationRecord
    VALID_MAJORS = [
        "Computer Engineering BS",
        "Computer Information Systems BS",
        "Computer Science BS",
        "Cybersecurity Major",
        "Data Science and Machine Learning Major"
      ]
    
      validates :major, inclusion: { in: VALID_MAJORS, message: "%{value} is not a valid major" }
   validates :first_name, presence: true
   validates :last_name, presence: true
   validates :major, presence: true
   has_one_attached :profile_picture
   validate :acceptable_image

   def acceptable_image
       return unless profile_picture.attached?

       unless profile_picture.blob.byte_size <= 1.megabyte
           errors.add(:profile_picture, "is too big")
       end

       acceptable_types = ["image/jpeg", "image/png"]
       unless acceptable_types.include?(profile_picture.content_type)
           errors.add(:profile_picture, "must be a JPEG or PNG")
       end

 end

end
