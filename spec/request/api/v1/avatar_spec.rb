describe 'Avatar API', type: :request do
  let!(:user) { create(:user) }
  let(:deliveryman) { create(:deliveryman) }
  let(:deliveryman_id) { deliveryman.id }
  let(:headers) { valid_headers }
  let(:avatar) { fixture_file_upload('spec/fixtures/avatar.png') }

  describe 'POST /deliverymans/:deliveryman_id/avatar' do
    subject do
      post "/deliverymans/#{deliveryman_id}/avatar",
           params: { avatar: avatar }, headers: headers
    end

    context 'when upload are success' do
      it 'returns status code 200' do
        subject
        expect(response).to have_http_status(200)
      end

      it 'uploads the file' do
        expect { subject }.to change(ActiveStorage::Attachment, :count).by(1)
      end

      it 'blob changes' do
        expect { subject }.to change(ActiveStorage::Blob, :count).by(1)
      end
    end
  end
end
