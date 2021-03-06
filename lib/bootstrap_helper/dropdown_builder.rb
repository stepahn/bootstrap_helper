module BootstrapHelper
  class DropdownBuilder < SimpleDelegator
    def initialize(cls, template)
      __setobj__(template)
      @cls = cls
      @menu = []
    end

    def render
      begin
        content_tag 'div', class: 'btn-group' do
          concat @main_btn
          concat btn_toggle_drowpdown
          menu = @menu.map {|i| content_tag 'li', i}.join('').html_safe
          concat content_tag('ul', menu, class: 'dropdown-menu', role: 'menu')
        end
      end.html_safe
    end

    def main(arg0, arg1=nil)
      @main_btn = if block_given?
        btn_to(arg0, arg1) do
          yield
        end
      else
        btn_to(arg0, arg1)
      end

      nil
    end

    def dropdown(*args)
      if block_given?
        anchor = capture do
          yield
        end
        args = args.unshift(anchor)
      end

      @menu << link_to(*args)
      nil
    end
  end
end
