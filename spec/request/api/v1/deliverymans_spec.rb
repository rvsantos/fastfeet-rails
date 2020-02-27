describe 'Deliveryman API', type: :request do
  let!(:user) { create(:user) }
  let(:headers) { valid_headers }

  describe 'POST /deliverymans' do
    subject { post '/deliverymans', params: params, headers: headers }

    context 'when attributes request are valid' do
      let(:params) { attributes_for(:deliveryman) }

      it 'returns status code 201' do
        subject
        expect(response).to have_http_status(201)
      end

      it 'returns a json data with deliveryman info' do
        subject
        expect(json_body).to have_key(:email)
      end

      it 'creates a deliveryman' do
        expect { subject }.to change(Deliveryman, :count).from(0).to(1)
      end

      it 'creates a blob' do
        expect { subject }.to change { ActiveStorage::Blob.count }.from(0).to(1)
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
        expect(json_body).to have_key(:errors)
      end

      it 'does not create a user' do
        expect { subject }.not_to change(Deliveryman, :count).from(0)
      end

      it 'does not create a blob' do
        expect { subject }.not_to change { ActiveStorage::Blob.count }.from(0)
      end
    end
  end
end
