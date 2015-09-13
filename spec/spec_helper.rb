$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'awit'

RSpec.configure do |c|

  c.before do
    Awit.configure do |config|
      config.content_type = config.accept = nil
    end
  end

end
