Dummy::Application.routes.draw do
  get 'penetrations/index'
  get 'penetrations/dynamic'
  get 'penetrations/dynamic_too_long'
  get 'penetrations/tag'
  get 'penetrations/preset'
  get 'penetrations/preset_too_long'
  get 'penetrations/with_no_param'
  get 'penetrations/with_param'
  get 'penetrations/with_multiple_params'
  get 'penetrations/double'
  get 'penetrations/with_scope'
end
