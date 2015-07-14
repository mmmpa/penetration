module Penetration
  def self.configure(&block)
    Configure.(&block) if block_given?
  end

  class Caller
    class << self
      def penetrate(session, session_name, element)
        session[session_name] ||= []
        session[session_name] << element
        session[session_name].compact
      end
    end
  end

  class Configure
    def self.call(&block)
      instance_eval(&block)
    end

    def self.preset(name, &block)
      Preset.(name, &block) if block_given?
    end
  end

  class Core
    def initialize(session, text = nil, &block)
      @session = session
      Caller.penetrate(@session, :rough_penetration, text) if text
      instance_eval(&block) if block_given?
    end

    def method_missing(name, *rest)
      preset = Preset.find(name)
      Caller.penetrate(@session, :rough_penetration, preset.is_a?(Proc) ? preset.(*rest) : preset)
    end
  end

  class Penetrator
    class << self
      def call(*args)
        new(*args)
      end
    end

    def initialize(session)
      @session = session
    end

    def render
      return '' if (elements = @session.delete(:rough_penetration)).nil?

      elements.flatten.map(&:html_safe).join
    end
  end

  class Preset
    class << self
      def call(name, &block)
        @preset ||= {}
        @preset[name] = yield
      end

      def find(name)
        @preset[name] || (raise NotFound)
      end
    end

    class NotFound < StandardError

    end
  end


  module ::ActionController
    module Renderers
      def _render_template(options)
        super.tap do |rendered|
          rendered.try(:<<, Penetration::Penetrator.(session).render) if formats.first == :html
        end
      end
    end

    class Base
      def penetrate(text = nil, &block)
        Penetration::Core.new(session, text, &block)
      end
    end
  end
end
