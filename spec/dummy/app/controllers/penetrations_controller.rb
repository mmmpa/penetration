class PenetrationsController < ApplicationController
  Penetration.configure do
    preset(:notify) { 'peenetrated notification!' }
    preset(:too_long) { 'peenetrated notification!' * 500 }
    preset(:alert) { ->(message) { "peenetrated #{message}" } }
    preset(:no_param) { -> { "peenetrated noparam!" } }
  end

  def index
  end

  def dynamic
    penetrate 'peenetrated penetration!'
    render :index
  end

  def dynamic_too_long
    penetrate 'peenetrated penetration!' * 500
    render json: {}
  end

  def tag
    penetrate '<strong>peenetrated penetration!</strong>'
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

  def double
    penetrate {
      alert 'alert1!'
      alert 'alert2!'
    }
    render :index
  end
end

