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

  end
end
