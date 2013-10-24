module BootstrapHelper
  class FormBuilder < ActionView::Helpers::FormBuilder
    delegate :content_tag, :tag, :concat, to: :@template

    def initialize(object_name, object, template, options, proc=nil)
      @horizontal = options.fetch(:horizontal, false)

      options[:html] ||= {}

      if horizontal?
        merge_class!(options[:html], 'form-horizontal')
      end

      super
    end

    def submit(value=nil, options={})
      merge_class!(options, 'btn btn-primary')
      options.reverse_merge!(name: nil, tabindex: tabindex)

      form_group do
        if horizontal?
          right_col(true) do
            super
          end
        else
          super
        end
      end
    end


    %w[email_field text_field text_area password_field collection_select].each do |method_name|
      define_method(method_name) do |name, *args|

        has_error = object.errors.include?(name)

        group_cls = 'has-error' if has_error

        options = args.extract_options!
        options.reverse_merge!(tabindex: tabindex)
        merge_class!(options, 'form-control')

        args << options

        if has_error
          error_messages = object.errors.full_messages_for(name).join(" ")
          error_tag = content_tag('span', error_messages, class: 'help-block')
        end

        input = if horizontal?
          right_col do
            super(name, *args) + error_tag
          end
        else
          super(name, *args) + error_tag
        end


        form_group group_cls do
          field_label(name, *args) + input
        end
      end
    end

  private
    def form_group(cls=nil)
      group_cls = ['form-group']
      group_cls << cls

      content_tag :div, class: to_class(group_cls) do
        yield
      end
    end

    def field_label(name, *args)
      options = args.extract_options!
      required = object.class.validators_on(name).any? { |v| v.kind_of? ActiveModel::Validations::PresenceValidator }

      options[:label] ||= {}

      cls = ['control-label']
      cls << 'required' if required
      cls << 'col-lg-2' if horizontal?

      merge_class!(options[:label], cls)

      label(name, options[:label])
    end

    def merge_class!(options, cls)
      options ||= {}
      _cls = options.fetch(:class, '')
      options[:class] = append_class(_cls, cls)
      options
    end

    def append_class(cls, new_cls)
      (cls + " " + to_class(new_cls)).strip
    end

    def horizontal?
      @horizontal == true
    end

    def to_class(a)
      return a.strip if a.is_a? String
      a.flatten.compact.uniq.join(' ')
    end

    def tabindex
      @tabindex ||= 0
      @tabindex += 1
    end

    def right_col(pad = false)
      cls = ['col-lg-10']
      cls << 'col-lg-offset-2' if pad

      content_tag :div, class: to_class(cls) do
        yield
      end
    end
  end
end
