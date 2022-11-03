# == Schema Information
#
# Table name: courses
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  prereq_id     :bigint
#  instructor_id :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Course < ApplicationRecord
    # checks for presence of name
    validates :name, presence: true,

    # a course can have many enrollments
    has_many :enrollments,
        primary_key: :id,
        foreign_key: :student_id,
        class_name: :Enrollment

    # a course can have many students
    has_many :enrolled_students,
        primary_key: :id,
        foreign_key: :student_id,
        class_name: :User

    # a course belong to a instructor
    belongs_to :instructor,
        primary_key: :id,
        foreign_key: :instructor_id,
        class_name: :User

    # association for prerequisite
    has_many :prerequisite,
        through: :course,
        source: :course,
        optional: true

end
