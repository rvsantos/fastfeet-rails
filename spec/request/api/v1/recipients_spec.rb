describe 'Recipients API', type: :request do
  let(:user) { create(:user) }
  let(:headers) { valid_headers }
  let!(:recipients) { create_list(:recipient, 10) }
  let(:recipient_id) { recipients.first.id }

  describe 'GET /recipients' do
    before { get '/recipients', params: {}, headers: headers }

    it 'returns all recipients' do
      expect(json_body.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'Get /recipients/:id' do
    before { get "/recipients/#{recipient_id}", params: {}, headers: headers }

    context 'when recipient exist' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns json data with recipient' do
        expect(json_body).to have_key(:street)
      end
    end

    context 'when recipient does not exist' do
      let(:recipient_id) { 1000 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
