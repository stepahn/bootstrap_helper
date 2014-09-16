require 'bootstrap_helper/view_helper'

module BootstrapHelper
  class Railtie < Rails::Railtie
    initializer "bootstrap_helper.view_helpers" do |app|
      ActionView::Base.send :include, BootstrapHelper::ViewHelper
    end
  end
end
