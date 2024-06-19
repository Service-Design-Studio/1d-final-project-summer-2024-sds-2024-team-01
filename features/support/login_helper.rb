module LoginHelpers
          def log_in_as(email, nric)
            visit login_path
            fill_in 'Email', with: email
            fill_in 'NRIC', with: nric
            click_button 'Log in'
          end
        end
        
        World(LoginHelpers)
        