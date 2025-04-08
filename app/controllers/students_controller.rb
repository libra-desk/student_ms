class StudentsController < ApplicationController
  before_action :find_student, only: [ :show, :update, :destroy ]

  def index
    students = Student.all
    render json: students
  end

  def show
    render json: @student
  end

  def create
    student = Student.new(student_params)

    if student.save
      render json: student, status: :created
    else
      render json: { errors: student.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @student.update(student_params)
      render json: student
    else
      render json: { errors: student.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @student
      @student.destroy
      head :no_content
    else
      render json: { error: "The student doesn't exist" }
    end
  end

  private

  def student_params
    params.permit(:name,
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
