class ApplicationController < ActionController::Base
    include SessionsHelper

    private
      # before_action
      # ログイン済みユーザーかどうか確認
      def logged_in_user
        unless logged_in?
          flash[:error] = "ログインしてください"
          redirect_to login_path
        end
      end
end
