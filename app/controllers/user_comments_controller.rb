class UserCommentsController < ApplicationController
  def create
    @comment = UserComment.new(comment_params)
    @comment.author_id = current_user.id
    unless @comment.save
      flash[:errors] = @comment.errors.full_messages
    end
    redirect_to user_url(@comment.user_id)
  end


  def destroy
    @comment = UserComment.find_by_id(params[:id])
    unless @comment.destroy
      flash[:errors] = @comment.errors.full_messages
    end
    redirect_to user_url(@comment.user_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body, :user_id)
  end
end
