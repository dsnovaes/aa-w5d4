# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    # checks for presence of name
    validates :name, presence: true

    has_many :enrollments,
        primary_key: :id,
        foreign_key: :student_id,
        class_name: :Enrollment,
        dependent: :destroy

    has_many :enrolled_courses,
        primary_key: :id,
        foreign_key: :course_id,
        class_name: :Course,
        dependent: :destroy
end
