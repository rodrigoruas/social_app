class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  include Pagy::Backend
  # skip_before_action :authenticate_user!, only: %i[ index show ]

  # GET /posts or /posts.json
  def index
    rel = Post.order(created_at: :desc)
    @pagy, @posts = pagy_countless(rel, limit: 15)
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end


  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if params[:send_option] == "later"
      SchedulePostJob.set(wait: 3.seconds).perform_later(@post.user.id, @post.content)
    else
      @post.save
      # render json: {}, status: :no_content
    end
    respond_to do |format|
      format.turbo_stream
    end

    # respond_to do |format|
    #   if @post.save
    #     # format.turbo_stream
    #     render json: {}, status: :no_content
    #   else
    #     format.html { render :index, status: :unprocessable_entity }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.expect(post: [ :content, :user_id ])
    end
end
