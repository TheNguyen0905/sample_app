class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show create new)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)
  before_action :load_user, except: %i(index new create)

  def index
    @users = User.activated.page(params[:page])
      .per Settings.user_paginate
  end

  def show
    @microposts = @user.microposts.order_by_created_at.page(params[:page])
      .per Settings.user_post_paginate
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "controller.user.flash_activation"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controller.user.flash_update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "controller.user.flash_destroy_s"
      redirect_to users_url
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end


  def correct_user
    @user = User.find_by id: params[:id]
    return if current_user? @user
    flash[:danger] = t "controller.user.flash_not_correct_user"
    redirect_to root_url
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
    flash[:danger] = t "controller.user.flash_not_correct_admin"
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "controller.user.flash_load_user"
    redirect_to root_url
  end
end
