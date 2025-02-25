class LikesController < ApplicationController
  include ActionView::RecordIdentifier
  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    if @like.save
      # write down an explanationn for this..
      render partial: "likes/like", locals: { post: @like.post, like: @like }
      # render turbo_stream: turbo_stream.replace(dom_id(@post, :likes), partial: "likes/like", locals: { post: @post, user: current_user })
    else
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @post = @like.post
    if @like.destroy
      render partial: "likes/like", locals: { post: @post, like: Like.new }
      # render turbo_stream: turbo_stream.replace(dom_id(@post, :likes), partial: "likes/like", locals: { post: @post, user: current_user })
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
