group 'backend' do
  guard 'bundler' do
    watch('Gemfile')
  end

  guard 'rspec', :cli => '--color --format doc' do
    # Regexp watch patterns are matched with Regexp#match
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})         { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^spec/models/.+\.rb$})   { ["spec/models", "spec/acceptance"] }

    # String watch patterns are matched with simple '=='
    watch('spec/spec_helper.rb') { "spec" }
  end
end
# 
