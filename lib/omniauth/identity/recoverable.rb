module OmniAuth
  module Identity
    module Recoverable
      # Update password saving the record and clearing token. Returns true if
      # the passwords are valid and the record was saved, false otherwise.
      def reset_password!(new_password, new_password_confirmation)
        self.password = new_password
        self.password_confirmation = new_password_confirmation

        clear_reset_password_token if valid?

        save
      end

      # Resets reset password token and send reset password instructions by email
      def send_reset_password_instructions
        generate_reset_password_token! if should_generate_reset_token?
        OmniAuth::Identity::Mailer.reset_password_instructions(self.user).deliver
      end

      protected

      # Removes reset_password token
      def clear_reset_password_token
        self.reset_password_token = nil
        self.reset_password_sent_at = nil
      end

      def should_generate_reset_token?
        self.reset_password_token.nil?
      end

      # Generates a new random token for reset password
      def generate_reset_password_token
        self.reset_password_token = new_reset_password_token
        self.reset_password_sent_at = Time.now.utc
        self.reset_password_token
      end

      # Resets the reset password token with and save the record without
      # validating
      def generate_reset_password_token!
        generate_reset_password_token && save(:validate => false)
      end

      ## Generates a new random token for confirmation, and stores the time
      ## this token is being generated
      #def generate_confirmation_token
      #  self.confirmation_token = new_confirmation_token
      #  self.confirmation_sent_at = Time.now.utc
      #end

      # Generate a token checking if one does not already exist in the database.
      def new_reset_password_token
        #It's only in Ruby 1.9
        #see https://github.com/rails/rails/commit/b3411ff59eb1e1c31f98f58f117a2ffaaf0c3ff5
        SecureRandom.base64.gsub("/","_").gsub(/=+$/,"")
      end
    end
  end
end
