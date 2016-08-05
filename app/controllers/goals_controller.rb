class GoalsController < ApplicationController
  before_action :require_sign_in!

  def index
    @goals = Goal.where(private: false)
    render :index
  end

  def show
    @goal = Goal.find_by_id(params[:id])
  end

  def new
    @goal = Goal.new
    @route = goals_url
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find_by_id(params[:id])
    @route = goal_url(@goal)
  end

  def update
    @goal = Goal.find_by_id(params[:id])
    unless current_user.id == @goal.id
      flash[:errors] = "Can not edit someone elses goals"
      redirect_to goal_url(@goal)
    else
      if @goal.update(boolean_params)
        redirect_to goal_url(@goal)
      else
        flash.now[:errors] = @goal.errors.full_messages
        render :edit
      end
    end
  end

  def destroy
    @goal = Goal.find_by_id(params[:id])
    if @goal.destroy
      redirect_to goals_url
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to goal_url(@goal)
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :details)
  end

  def boolean_params
    goal = { private: params[:goal][:private] || false,
             completed: params[:goal][:completed] || false }
    goal_params.merge(goal )
  end
end
