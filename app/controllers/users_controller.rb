class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    if signed_in?
      redirect_to root_path
    else
      @user = User.new
      @title = "Sign up"
    end
  end
  
  def create
    if signed_in?
      redirect_to root_path
    else
      @user = User.new(params[:user])
      if @user.save
         sign_in @user
         Notifier.activate(@user).deliver

         flash[:notice] = "Signup successful. Activation e-mail has been sent to your email.Please go to check it."
#redirect_to "#"
#flash[:success] = "Welcome to Apex Studio."
      
#       redirect_to @user
      else
        @title = "Sign up"
        @user.password = ""
        @user.password_confirmation = ""
        render 'new'
      end
    end
  end

  def edit
    @title = "Edit user"
  end

  def update
#   @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit"
      render 'edit'
    end
  end

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def destroy
    user = User.find(params[:id])
    if user.admin?
      flash[:error] = "Can't destroy admin."
    else
      user.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end
  
  def activate
#      @user = params[:code].blank? ? false: User.find_by_activation_code(params[:code])
      @user = params[:code].blank? ? false : User.find_by_activation_code(params[:code])      
      if signed_in? && !@user.activated?
        @user.update_attribute(:activation_code,  nil)
        @user.update_attribute(:activated_at, Time.now)
        @user.update_attribute(:password, @user.password)
        flash[:notice] = "Signup complete!"
        redirect_to current_user
      else
        redirect_to signin_path
      end
  end

  private
    def authenticate
      deny_access if !signed_in? || !current_user.activated?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
