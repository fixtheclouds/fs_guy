require 'simplecov'

SimpleCov.minimum_coverage 90
SimpleCov.start do
  add_filter '/spec/'
end
