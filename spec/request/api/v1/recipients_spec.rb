describe 'Recipients API', type: :request do
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let!(:recipients) { create_list(:recipient, 10) }
  let(:recipient_id) { recipients.first.id }
  let(:page) { 1 }

  describe 'GET /recipients' do
    before { get "/recipients?page=#{page}", params: {}, headers: headers }

    it 'returns all recipients' do
      expect(json_body[:data].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    context 'when returns page 2' do
      let(:page) { 2 }

      it 'json data must be empty' do
        expect(json_body[:data]).to be_empty
      end
    end
  end

  describe 'Get /recipients/:id' do
    before { get "/recipients/#{recipient_id}", params: {}, headers: headers }

    context 'when recipient exist' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns json data with recipient' do
        expect(json_body[:data][:attributes]).to have_key(:street)
      end
    end

    context 'when recipient does not exist' do
      let(:recipient_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /recipients' do
    before do
      post '/recipients', params: recipient_params.to_json, headers: headers
    end

    context 'when request attributes are valid' do
      let(:recipient_params) { attributes_for(:recipient) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the user created' do
        expect(json_body[:data][:attributes][:name]).to eq(recipient_params[:name])
      end
    end

    context 'when request attributes are invalid' do
      let(:recipient_params) { attributes_for(:recipient).except(:state) }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns json data with error message' do
        expect(json_body[:message]).to match(/Validation failed/)
      end
    end
  end

  describe 'PUT /recipients/:id' do
    before do
      put "/recipients/#{recipient_id}", params: recipient_params.to_json,
                                         headers: headers
    end

    context 'when request attributes are valid' do
      let(:recipient_params) { { street: 'Rua silvio bueno peruche' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the user created' do
        expect(json_body[:data][:attributes][:street]).to eq(recipient_params[:street])
      end
    end

    context 'when request attributes are invalid' do
      let(:recipient_params) { { street: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns json data with error message' do
        expect(json_body[:message]).to match(/Validation failed/)
      end
    end
  end

  describe 'DELETE /recipients/:id' do
    before { delete "/recipients/#{recipient_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'remove recipient from database' do
      expect(Recipient.find_by(id: recipient_id)).to be_nil
    end
  end
end
