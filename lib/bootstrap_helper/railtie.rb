require 'bootstrap_helper/view_helper'

module BootstrapHelper
  class Railtie < Rails::Railtie
    initializer "tabindex.view_helpers" do |app|
      ActionView::Base.send :include, ViewHelper
    end
  end
end
