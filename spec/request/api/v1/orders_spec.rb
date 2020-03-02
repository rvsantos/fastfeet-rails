describe 'Orders API', type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:deliveryman) { create(:deliveryman) }
  let(:deliveryman_id) { deliveryman.id }
  let(:recipients) { create_list(:recipient, 2) }
  let(:recipient_id) { recipients.first.id }
  let!(:order) { create(:order) }
  let(:order_id) { order.id }
  let(:headers) { valid_headers }
  let(:valid_params) do
    {
      'recipient_id': recipient_id,
      'deliveryman_id': deliveryman_id,
      'product': 'Bicicleta Yamaha'
    }
  end

  describe 'POST /orders' do
    before do
      post '/orders', params: params.to_json, headers: headers
    end

    context 'when request attributes are valid' do
      let(:params) { valid_params }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns order relationships' do
        expect(json_body[:data][:relationships].count).to eq(2)
      end
    end

    context 'when request attributes are invalid' do
      let(:params) { valid_params.except(:product) }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET /orders' do
    before do
      create_list(:order, 5)
      get '/orders', params: {}, headers: headers
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns all orders' do
      expect(json_body[:data].count).to eq(6)
    end
  end

  describe 'GET /orders/:id' do
    before do
      get "/orders/#{order_id}", params: {}, headers: headers
    end

    context 'when order request exist' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns json data with order' do
        expect(json_body[:data][:attributes]).to have_key(:product)
      end
    end

    context 'when order request does not exist' do
      let(:order_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns json data with error message' do
        expect(json_body[:message]).to match(/Couldn't find Order/)
      end
    end
  end

  describe 'PUT /orders/id' do
    before do
      put "/orders/#{order_id}", params: params.to_json, headers: headers
    end

    context 'when request attributes are valid' do
      let(:params) { { product: 'bike bike bike', recipient_id: recipients.last.id } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns json data with order' do
        expect(json_body[:data][:attributes][:product]).to eq(params[:product])
      end

      it 'must change relationships' do
        expect(json_body[:data][:relationships][:recipient][:data][:id].to_i).to eq(recipients.last.id)
      end
    end

    context 'when order request does not exist' do
      let(:params) { { product: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns json data with error message' do
        expect(json_body[:message]).to match(/Product can't be blank/)
      end
    end
  end

  describe 'DELETE /orders/:id' do
    subject { delete "/orders/#{order_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      subject
      expect(response).to have_http_status(204)
    end

    it 'remove order from database' do
      expect { subject }.to change(Order, :count).from(1).to(0)
    end
  end

  describe '/orders/:id/withdrawal' do
    before { post "/orders/#{order_id}/withdrawal", params: {}, headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns json data with start_date' do
      expect(json_body[:data][:attributes][:start_date]).not_to be_nil
    end
  end
end
