class StudentsController < ApplicationController
  before_action :find_student, only: [ :show, :update, :destroy ]

  def index
    Rails.logger.info("Fetching all students from db or cache. Lets see")
    cached_students = Rails.cache.fetch("all_students") do
      Rails.logger.info("A cache miss")
      Student.all.to_json
    end

    render json: cached_students
  end

  def show
    render json: @student
  end

  def create
    student = Student.new(student_params)
    if student.save
      Rails.cache.delete("all_students")
      render json: student, status: :created
    else
      render json: { errors: student.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @student.update(student_params)
      Rails.cache.delete("all_students")
      render json: @student
    else
      render json: { errors: @student.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @student
      @student.destroy
      Rails.cache.delete("all_students")
      head :no_content
    else
      render json: { error: "The student doesn't exist" }
    end
  end

  private

  def student_params
    params.require(:student).permit(:name,
                  :branch,
                  :email,
                  :phone_number,
                  :year_of_study
                 )
  end

  def find_student
    @student = Student.find_by(id: params[:id])
  end
end
