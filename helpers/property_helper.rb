module PropertyHelper
  def check_params
    if invalid_params.size > 0
      json = { message: 'Params invalid', params: invalid_params }.to_json

      status 422
      halt json
    end
  end

  def invalid_params
    collection = []

    collection << :property_type unless Property.property_type_valid?(params[:property_type])
    collection << :marketing_type unless Property.offer_type_valid?(params[:marketing_type])
    collection << :lat unless current_lat.abs > 0
    collection << :lng unless current_lng.abs > 0

    collection
  end

  def current_lat
    params[:lat].to_f
  end

  def current_lng
    params[:lng].to_f
  end

  def offset_number_for(pagination)
    page = params[:page].to_i.abs

    return 0 if page <= 1

    (page - 1) * pagination
  end
end

helpers PropertyHelper
