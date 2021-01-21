require 'simplecov'

SimpleCov.minimum_coverage 75
SimpleCov.start do
  add_filter '/spec/'
end
