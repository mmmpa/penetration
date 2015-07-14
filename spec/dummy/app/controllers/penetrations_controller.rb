

class PenetrationsController < ApplicationController
  Penetration.configure do
    preset(:notify) { 'peenetrated notification!' }
    preset(:alert) { ->(message) { "peenetrated #{message}" } }
  end

  def index
  end

  def dynamic
    penetrate 'peenetrated penetration!'
  end

  def tag
    penetrate '<strong>peenetrated penetration!</strong>'
    render :dynamic
  end

  def preset
    penetrate {
      notify
    }
  end

  def with_param
    penetrate {
      alert 'alert!'
    }
  end

  def double
    penetrate {
      alert 'alert1!'
      alert 'alert2!'
    }
  end
end

