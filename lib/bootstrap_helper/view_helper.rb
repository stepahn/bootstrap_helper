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

    def bicon(icon)
      cls = %w{glyphicon} + ["glyphicon-#{icon}"]
      content_tag 'span', '', class: cls.join(" ")
    end

  end
end
