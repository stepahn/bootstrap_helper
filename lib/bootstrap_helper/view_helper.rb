require 'bootstrap_helper/dropdown_builder'

module BootstrapHelper
  module ViewHelper
    def bdesc
      content_tag :dl, class: 'dl-horizontal' do
        yield
      end
    end

    def bdesc_entry(label, value)
      if value.blank?
        value = '&nbsp;'.html_safe
      end
      content_tag(:dt, label) + content_tag(:dd, value)
    end

    def bpage_header
      content_tag :div, class: 'page-header' do
        content_tag :h1 do
          yield
        end
      end
    end

    def btn_to(arg0, arg1 = nil, arg2 = nil, arg3 = nil)
      css, opts = block_given? ? [arg1, arg2] : [arg2, arg3]
      css ||= %w{btn-default}
      opts ||= {}

      cls = (%w{btn} << css).flatten.compact.join(' ')

      options = {class: cls}.merge(opts)

      if block_given?
        link_to arg0, options do
          yield
        end
      else
        link_to arg0, arg1, options
      end
    end

    def btn_toggle_drowpdown(cls = %w{btn-default})
      default_cls = %w{btn dropdown-toggle}
      _cls = (default_cls + cls).flatten.compact.join(' ')
      content_tag 'button', type: 'button', class: _cls, data: {toggle: 'dropdown'} do
        tag 'span', class: 'caret'
      end
    end

    def bicon(icon)
      cls = %w{glyphicon} + ["glyphicon-#{icon}"]
      content_tag 'span', '', class: cls.join(" ")
    end

    def btn_dropdown(cls = 'btn-default', &block)
      b = DropdownBuilder.new(cls, self)
      b.instance_eval(&block)
      b.render
    end

    def badge(count, css='')
      css_class = ['badge', css].compact.join(' ')
      content_tag :span, count, class: css_class
    end

    def blb(text, *extra_classes)
      css_class = (%w(label label-default) << extra_classes).flatten.compact.join(' ')
      content_tag :span, text, class: css_class
    end
  end
end
