class PenetrationsController < ApplicationController
  Penetration.configure do
    preset(:notify) { 'penetrated notification!' }
    preset(:too_long) { 'penetrated notification!' * 500 }
    preset(:alert) { ->(message) { "penetrated #{message}" } }
    preset(:no_param) { -> { "penetrated noparam!" } }
    preset(:multiple) { ->(a, b) { "penetrated #{a} #{b}" } }
  end

  def index
  end

  def dynamic
    penetrate 'penetrated penetration!'
    render :index
  end

  def dynamic_too_long
    penetrate 'penetrated penetration!' * 500
    render json: {}
  end

  def tag
    penetrate '<strong>penetrated penetration!</strong>'
    render :index
  end

  def preset
    penetrate {
      notify
    }
    render :index
  end

  def preset_too_long
    penetrate {
      too_long
    }
    render json: {}
  end

  def with_no_param
    penetrate {
      no_param
    }
    render :index
  end

  def with_param
    penetrate {
      alert 'alert!'
    }
    render :index
  end

  def with_multiple_params
    penetrate {
      multiple 'alert!', 'alert!!'
    }
    render :index
  end

  def double
    penetrate {
      alert 'alert1!'
      alert 'alert2!'
    }
    render :index
  end
end

