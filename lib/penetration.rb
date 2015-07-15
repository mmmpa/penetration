module Penetration
  def self.configure(&block)
    Configure.(&block) if block_given?
  end

  class Caller
    def initialize(session, session_name)
      @session = session
      @session_name = session_name
      @session[@session_name] ||= []
    end

    def current_session
      @session[@session_name]
    end

    def add_raw(raw)
      add(:raw, raw)
    end

    def add_preset(preset)
      add(:preset, preset)
    end

    def add(mode, element)
      current_session << [mode, element]
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
      @caller = Caller.new(@session, :rough_penetration)
      @caller.add_raw(text) if text
      instance_eval(&block) if block_given?
    end

    def method_missing(name, *rest)
      if Preset.find(name)
        @caller.add_preset([name, *rest].flatten)
      end
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
      elements.map do |element|
        case element.first.to_sym
          when :raw
            element.last
          when :preset
            preset = Preset.find(element.last.shift) rescue next
            if preset.is_a?(Proc)
              element.last.present? ? preset.(*element.last) : preset.()
            else
              preset
            end
          else
            # do nothing
        end
      end.compact.join.html_safe
    end
  end

  class Preset
    class << self
      def call(name, &block)
        @preset ||= {}
        @preset[name.to_sym] = yield
      end

      def find(name)
        @preset[name.to_sym] || (raise NotFound)
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
