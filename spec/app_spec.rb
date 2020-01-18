require File.expand_path '../spec_helper.rb', __FILE__

describe 'App' do
  let(:params) { { property_type: 'apartment', marketing_type: 'sell', lat: 52.534296, lng: 13.4236807 } }
  let!(:property_within_search) do
    create :property,
      lat: 52.53177508, lng: 13.38815072,
      property_type: 'apartment', offer_type: 'sell'
  end

  before do
    create :property, lat: 52.5069238, lng: 13.4201547, property_type: 'apartment_roof_storey', offer_type: 'sell'
    create :property, lat: 30.0, lng: 20.0, property_type: 'apartment', offer_type: 'rent'
  end

  subject { get '/stats', params }

  it 'accesses the endpoint and returns at least one object' do
    subject

    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body).size == 1).to be(true)
  end

  context 'when the params passed are invalid' do
    context 'when the property_type is invalid' do
      before { params[:property_type] = 'invalid' }

      it 'return the error response' do
        subject

        expect(last_response.status).to be(422)
        expect(JSON.parse(last_response.body)).to eq({ 'message' => 'Params invalid', 'params' => ['property_type'] })
      end
    end

    context 'when the marketing_type is invalid' do
      before { params[:marketing_type] = 'invalid' }

      it 'return the error response' do
        subject

        expect(last_response.status).to be(422)
        expect(JSON.parse(last_response.body)).to eq({ 'message' => 'Params invalid', 'params' => ['marketing_type'] })
      end
    end

    context 'when the latitude is invalid' do
      before { params[:lat] = 'invalid' }

      it 'return the error response' do
        subject

        expect(last_response.status).to be(422)
        expect(JSON.parse(last_response.body)).to eq({ 'message' => 'Params invalid', 'params' => ['lat'] })
      end
    end

    context 'when the longitude is invalid' do
      before {  params[:lng] = 'invalid' }

      it 'return the error response' do
        subject

        expect(last_response.status).to be(422)
        expect(JSON.parse(last_response.body)).to eq({ 'message' => 'Params invalid', 'params' => ['lng'] })
      end
    end

    context 'when there are a few params invalid' do
      let(:result) do
        {
          'message' => 'Params invalid',
          'params' => %w[property_type marketing_type lng]
        }
      end

      before do
        params[:property_type] = 'invalid'
        params[:marketing_type] = 'invalid'
        params[:lng] = 'invalid'
      end

      it 'return the error response' do
        subject

        expect(last_response.status).to be(422)
        expect(JSON.parse(last_response.body)).to eq(result)
      end
    end
  end

  context 'when there is no property found' do
    before { property_within_search.update!(offer_type: 'rent') }

    it 'returns the error message' do
      subject

      expect(last_response.status).to be(404)
      expect(JSON.parse(last_response.body)).to eq({ 'message' => 'No data for given location' })
    end
  end
end
