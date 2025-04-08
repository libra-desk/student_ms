class Student < ApplicationRecord
  validates_presence_of :name,
                        :branch,
                        :email,
                        :phone_number,
                        :year_of_study

  validates :email,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP,
              message: "is not a valid email"
            }
end
