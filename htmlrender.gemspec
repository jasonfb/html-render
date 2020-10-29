require './lib/version'

Gem::Specification.new do |s|
  s.name        = 'htmlrender'
  s.version     = HtmlRender::VERSION
  s.date        = '2020-10-29'
  s.summary     = "HTML Render Gem"
  s.description = "Render HTML inside a JSON Response in Rails"
  s.authors     = ["Jason Fleetwood-Boldt"]
  s.email       = 'jason.fb@datatravels.com'
  s.files       = ["lib/htmlrender.rb"]
  s.homepage    = 'https://blog.jasonfleetwoodboldt.com/html-render/'
  s.license       = 'MIT'
end