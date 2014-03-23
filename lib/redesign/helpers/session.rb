module ExercismIO
  module Helpers
    module Session
      def login(user)
        session[:github_id] = user.github_id
        @current_user = user
      end

      def logout
        session[:github_id] = nil
        @current_user = nil
      end

      def current_user
        @current_user ||= logged_in_user || Guest.new
      end

      def login_url(return_path = nil)
        url = Github.login_url(github_client_id)
        url << redirect_uri(return_path) if return_path
        url
      end

      private

      def redirect_uri(return_path)
        "&redirect_uri=http://#{host}/github/callback#{return_path}"
      end

      def logged_in_user
        if session[:github_id]
          User.find_by(github_id: session[:github_id])
        end
      end
    end
  end
end
