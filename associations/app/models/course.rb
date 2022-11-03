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
    validates :name, presence: true

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

    # lists courses that are pre-requisite of self
    belongs_to :prerequisite, # SELECT "courses".* FROM "courses" WHERE "courses"."id" = $1 LIMIT $2
        primary_key: :id,
        foreign_key: :prereq_id, # search for :prereq_id in the id column
        class_name: :Course,
        optional: true # must bu used with belongs_to. won't work with has_many

    # lists courses that self is pre-requisite for
    has_many :prereqs, # SELECT "courses".* FROM "courses" WHERE "courses"."prereq_id" = $1
        primary_key: :id,
        foreign_key: :prereq_id, # search for :id in the prereq_id column
        class_name: :Course

end
