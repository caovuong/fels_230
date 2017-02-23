class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :find_lesson, only: [:show, :update]

  def index
    @lessons = Lesson.order_by_id.paginate page: params[:page],
      per_page: Settings.per_page
    @lesson = Lesson.new
    @categories ||= Category.all.collect{|category| [category.name, category.id]}
  end

  def show
    @words = @lesson.category.words
    if @lesson.is_completed?
      @answers = @lesson.answers
    else
      flash[:success] = t "lessons.do_lesson"
    end
  end

  def new
    @lesson = Lesson.new
    @categories ||= Category.all.collect{|category| [category.name, category.id]}
  end

  def create
    @lesson = current_user.lessons.build lesson_params
    if @lesson.save
      flash[:success] = t "lessons.create_success"
      redirect_to lessons_url
    else
      flash[:danger] = t "lessons.create_unsuccess"
      redirect_to lessons_url
    end
  end

  def update
    if @lesson.update_attributes lesson_params.merge is_completed: true
      redirect_to @lesson
      flash[:success] = t "lessons.save"
    else
      flash[:danger] = t "lessons.fail"
      redirect_to :back
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :user_id, :category_id,
      results_attributes: [:id, :word_id, :answer_id, :_destroy]
  end

  def find_lesson
    @lesson = Lesson.find_by id: params[:id]
    unless @lesson
      flash[:danger] = t "lessons.err"
      redirect_to lessons_url 
    end
  end
end
