# encoding: utf-8

module HtmlSnapshot
  module Model
    def self.included(klass)
      klass.class_eval do
        class << self
          def export
            doc   = Nokogiri::HTML(load_html)
            links = doc.css('a')
            hrefs = links.map { |link| link.attribute('href').to_s }.uniq.sort.delete_if { |href| href.empty? }
            assert links.count.eql?(18), "parser doesn't detect all links"
            assert hrefs.count.eql?(17), "parser doesn't extract all href"
          end
        end
      end
    end
  end
end