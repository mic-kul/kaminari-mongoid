# frozen_string_literal: true
require 'kaminari/mongoid/mongoid_criteria_methods'

module Kaminari
  module Mongoid
    module MongoidExtension
      module Document
        extend ActiveSupport::Concern
        include Kaminari::ConfigurationMethods

        included do
          scope Kaminari.config.page_method_name, Proc.new {|num|
            limit(default_per_page).offset(default_per_page * ((num = num.to_i - 1) < 0 ? 0 : num))
          } do
            include Kaminari::Mongoid::MongoidCriteriaMethods
            include Kaminari::PageScopeMethods
          end
        end
      end
    end
  end
end
