class TasksController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @tasks = Task.all
  end

  def show
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @user = User.find(params[:user_id])
    @task = @user.tasks.build(task_params)
    if@task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render
    end
  end
  

  def edit
    @user = User.find(params[:user_id])
    @task = @user.tasks.find_by(id: params[:id])
  end
  

  def update
     @user = User.find(params[:user_id])
     @task = @user.tasks.find_by(id: params[:id])
     
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_url(@user, @task)
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to user_tasks_path, notice: "削除しました"
  end
  
  private
  def task_params
    params.require(:task).permit(:name, :description)
  end
end
