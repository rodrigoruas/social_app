class LikesController < ApplicationController
  include ActionView::RecordIdentifier
  def create
    @like = current_user.likes.build(like_params)
    if true
      # render partial: "likes/like", locals: { post: @like.post }
      render turbo_stream: turbo_stream.replace(dom_id(:likes, @like.post.id), partial: "likes/like", locals: { post: @like.post })
    else
    end
  end

  private 

  def like_params
    params.require(:like).permit(:post_id)
  end
end
