describe 'Users API', type: :request do
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }
  let(:headers) do
    {
      'Content-Type': Mime[:json].to_s,
      Accept: 'application/vnd.fastfeet.v1'
    }
  end

  describe 'GET /users' do
    before { get '/users', params: {}, headers: headers }

    it 'returns all users' do
      expect(json_body.size).to eq 10
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:id' do
    before { get "/users/#{user_id}", params: {}, headers: headers }

    context 'when the record exist' do
      it 'returns the user' do
        expect(json_body[:id]).to eq user_id
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /users' do
    before { post '/users', params: attributes.to_json, headers: headers }

    context 'when request attributes are valid' do
      let(:attributes) { attributes_for(:user) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns json data the user created' do
        expect(json_body).to have_key(:email)
      end
    end

    context 'when request attributes are invalid' do
      let(:attributes) { attributes_for(:user).except(:email) }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns json data with errors' do
        expect(json_body).to have_key(:errors)
      end
    end
  end

  describe 'PUT /users/:id' do
    before { put "/users/#{user_id}", params: attributes.to_json, headers: headers }

    context 'when request attributes are valid' do
      let(:attributes) { { name: 'Novo Nome' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns json data the user created' do
        expect(json_body[:name]).to eq attributes[:name]
      end
    end

    context 'when request attributes are invalid' do
      let(:attributes) { { name: '' } }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns json data with errors' do
        expect(json_body).to have_key(:errors)
      end
    end
  end
end
