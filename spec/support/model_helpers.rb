module ModelHelpers
  def stub_model(name = nil, superclass = nil, &block)
    stub_class(name, superclass) { include Granite::Form::Model }.tap { |klass| klass.class_eval(&block) if block }
  end

  def stub_class(name = nil, superclass = nil, &)
    klass = superclass ? Class.new(superclass, &) : Class.new(&)
    name.present? ? stub_const(name.to_s.camelize, klass) : klass
  end
end
