module Dashboard
  class AdminUsersController < BaseController
    before_action :set_admin_user, only: %w[show edit update]
    helper_method :order_params

    def index
      service = Search::AdminUsersService.new(search_params)
      @admin_users = service.execute
    end

    def new
      @admin_user = AdminUser.new
    end

    def create
      @admin_user = AdminUser.new
      save_admin_user('created', :new)
    end

    def show; end

    def edit; end

    def update
      save_admin_user('updated', :edit)
    end

    def destroy
      flash[:notice] = if admin_user_destroyed?
                         'Admin user destroyed successfully.'
                       else
                         'Admin user could not be destroyed.'
                       end
      redirect_to dashboard_admin_users_path
    end

    def order_params(order, direction)
      params.merge(o: order, d: direction, page: params[:page], q: params[:q]).permit(:o, :d, :page, q: :name)
    end

    private

    def save_admin_user(action, form_partial)
      inputs = { admin_user: @admin_user, attrs: admin_user_params }
      outcome = ::AdminUsers::CreateOrUpdate.run(inputs)

      if outcome.valid?
        flash[:notice] = "Admin user #{action} successfully."
        redirect_to dashboard_admin_user_path(outcome.result)
      else
        flash[:notice] = "Admin user could not be #{action}."
        @admin_user = outcome.result
        render form_partial
      end
    end

    def search_params
      params[:o] = params[:o].presence || params.dig(:q, :o)
      params[:d] = params[:d].presence || params.dig(:q, :d)
      order_params(params[:o], params[:d])
    end

    def set_admin_user
      @admin_user = AdminUser.find_by(id: params[:id])
    end

    def admin_user_destroyed?
      ::AdminUsers::Destroy.run({ id: params[:id] }).valid?
    end

    def admin_user_params
      params.require(:admin_user).permit(
        :email, :name, :password, :password_confirmation, :age, :phone, :address
      )
    end
  end
end
