# encoding: utf-8

Rails.application.config.html-snapshot.submodules = []

Rails.application.config.html-snapshot.configure do |config|
  config.classes = [ "Project", "Version" ]
end