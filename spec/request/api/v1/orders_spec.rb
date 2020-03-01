describe 'Orders API', type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:deliveryman) { create(:deliveryman) }
  let(:deliveryman_id) { deliveryman.id }
  let(:recipient) { create(:recipient) }
  let(:recipient_id) { recipient.id }
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
end
