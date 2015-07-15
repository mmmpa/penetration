require 'rails_helper'

describe 'Penetrations', type: :request do
  before :each do
    get '/penetrations/index'
  end

  it do
    get '/penetrations/index'
    expect(response.body).not_to include('penetrated penetration!')
  end

  it do
    get '/penetrations/dynamic'
    expect(response.body).to include('penetrated penetration!')
  end

  it do
    expect {
      get '/penetrations/dynamic_too_long'
    }.to raise_exception(ActionDispatch::Cookies::CookieOverflow)
  end

  it do
    get '/penetrations/tag'
    expect(response.body).to include('<strong>penetrated penetration!</strong>')
  end

  it do
    get '/penetrations/preset'
    expect(response.body).to include('penetrated notification!')
  end

  it do
    get '/penetrations/preset_too_long'
    get '/penetrations/index'
    expect(response.body).to include('penetrated notification!' * 10)
  end

  it do
    get '/penetrations/with_no_param'
    expect(response.body).to include('penetrated noparam!')
  end

  it do
    get '/penetrations/with_param'
    expect(response.body).to include('penetrated alert!')
  end

  it do
    get '/penetrations/with_multiple_params'
    expect(response.body).to include('penetrated alert! alert!!')
  end

  it do
    get '/penetrations/double'
    expect(response.body).to include('penetrated alert1!')
  end

  it do
    get '/penetrations/double'
    expect(response.body).to include('penetrated alert2!')
  end

  it do
    get '/penetrations/with_scope'
    expect(response.body).to include('penetrated doing')
  end

end