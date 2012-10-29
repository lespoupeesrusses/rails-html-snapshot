# encoding: utf-8

module HtmlSnapshot

  autoload :Model, 'html-snapshot/model'
  module Model
    autoload :Exporter, 'html-snapshot/model/exporter'
  end

  if defined?(ActiveRecord)
    # ActiveRecord::Base.send :include, HtmlSnapshot::Model
    #ActiveRecord::Base.send :include, HtmlSnapshot::Model::Exporter
  end

end