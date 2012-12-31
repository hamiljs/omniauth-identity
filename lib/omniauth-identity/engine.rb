module OmniAuth
  module Identity
    class Engine < ::Rails::Engine
      isolate_namespace ::OmniAuth::Identity
    end
  end
end
