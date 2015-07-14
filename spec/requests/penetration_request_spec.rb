require 'rails_helper'

describe 'Penetrations', type: :request do
  before :each do
    get '/penetrations/index'
  end

  it do
    get '/penetrations/index'
    expect(response.body).not_to include('peenetrated penetration!')
  end

  it do
    get '/penetrations/dynamic'
    expect(response.body).to include('peenetrated penetration!')
  end

  it do
    get '/penetrations/tag'
    expect(response.body).to include('<strong>peenetrated penetration!</strong>')
  end

  it do
    get '/penetrations/preset'
    expect(response.body).to include('peenetrated notification!')
  end

  it do
    get '/penetrations/with_param'
    expect(response.body).to include('peenetrated alert!')
  end

  it do
    get '/penetrations/double'
    expect(response.body).to include('peenetrated alert1!')
  end

  it do
    get '/penetrations/double'
    expect(response.body).to include('peenetrated alert2!')
  end
end