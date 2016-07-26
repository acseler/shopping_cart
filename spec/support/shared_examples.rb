RSpec.shared_examples 'user not authorized' do
  context 'redirect to sign in form' do
    it { expect(action).to redirect_to new_user_session_path }
  end
end