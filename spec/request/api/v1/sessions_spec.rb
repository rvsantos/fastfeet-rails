describe 'Sessions API', type: :request do
  describe 'POST /sessions' do
    # create test user
    let!(:user) { create(:user, email: 'admin@fastfeet.com') }
    # set headers for authorization
    let(:headers) { valid_headers.except('Authorization') }
    # set test valid and invalid credentials
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    before do
      post '/sessions', params: credentials, headers: headers
    end

    context 'when credentials are valid' do
      let(:credentials) { valid_credentials }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns json data with  auth_token' do
        expect(json_body[:auth_token]).not_to be_nil
      end
    end

    context 'when credentials are invalid' do
      let(:credentials) { invalid_credentials }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
