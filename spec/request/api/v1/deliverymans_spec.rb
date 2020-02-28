describe 'Deliveryman API', type: :request do
  let!(:user) { create(:user) }
  let(:headers) { valid_headers }

  describe 'POST /deliverymans' do
    subject { post '/deliverymans', params: params.to_json, headers: headers }

    context 'when attributes request are valid' do
      let(:params) { attributes_for(:deliveryman) }

      it 'returns status code 201' do
        subject
        expect(response).to have_http_status(201)
      end

      it 'creates a deliveryman' do
        expect { subject }.to change(Deliveryman, :count).from(0).to(1)
      end

      it 'returns a json data with deliveryman info' do
        subject
        expect(json_body[:data][:attributes]).to have_key(:email)
      end
    end

    context 'when attributes request are invalid' do
      let(:params) { attributes_for(:deliveryman).except(:email) }

      it 'returns status code 422' do
        subject
        expect(response).to have_http_status(422)
      end

      it 'retuns a JSON response' do
        subject
        expect(json_body[:message]).to match(/Email can't be blank/)
      end

      it 'does not create a user' do
        expect { subject }.not_to change(Deliveryman, :count).from(0)
      end
    end
  end

  describe 'GET /deliverymans' do
    subject { get '/deliverymans', params: {}, headers: headers }

    let!(:deliverymans) { create_list(:deliveryman, 10) }

    it 'returns status code 200' do
      subject
      expect(response).to have_http_status(200)
    end

    it 'return json data with deliveryman email' do
      subject
      expect(json_body[:data].first[:attributes]).to have_key(:email)
    end

    it 'returns all deliverymans' do
      expect(Deliveryman.count).to eq(10)
    end
  end
end
