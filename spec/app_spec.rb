require File.expand_path '../spec_helper.rb', __FILE__

describe 'App' do
  let(:params) { { property_type: 'apartment', marketing_type: 'sell', lat: 52.534296, lng: 13.4236807 } }

  before do
    create :property, lat: 52.53177508, lng: 13.38815072, property_type: 'apartment', offer_type: 'sell'
    create :property, lat: 52.5069238, lng: 13.4201547, property_type: 'apartment_roof_storey', offer_type: 'sell'
    create :property, lat: 30.0, lng: 20.0, property_type: 'apartment', offer_type: 'rent'
  end

  subject { get '/stats', params }

  it 'accesses the endpoint and returns at least one object' do
    subject

    expect(last_response).to be_ok
    expect(JSON.parse(last_response.body).size > 0).to be(true)
  end
end
