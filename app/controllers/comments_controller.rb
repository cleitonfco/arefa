class CommentsController < ApplicationController
  before_filter :load_project_task

  def load_project_task
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id])
  end

  # GET /comments/new
  # GET /comments/new.xml
  #def new
  #  @comment = @task.comments.build
  #
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.xml  { render :xml => @comment }
  #  end
  #end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = @task.comments.build(params[:comment])

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to([@project, @task]) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html #{ redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
end
