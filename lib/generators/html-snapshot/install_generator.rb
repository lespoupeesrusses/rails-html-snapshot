# encoding: utf-8

module HtmlSnapshot
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def copy_initializer_file
        template "initializer.rb", "config/initializers/html-snapshot.rb"
      end
    end
  end
end