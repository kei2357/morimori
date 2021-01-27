class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.create(task_params)
    @task.save
      redirect_to user_tasks_path, notice: "登録しました"
  end

  def edit
    @task = Task.find(params[:id])
  end
  
  
  

  def update
     @task = Task.find(params[:id])
  if @task.update(task_params)
     flash[:success] = 'タスクが編集されました'
     redirect_to user_task_path(@task)
  else
    flash.now[:danger] = 'タスクが編集されませんでした'
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
