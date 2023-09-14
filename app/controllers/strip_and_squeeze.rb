module StripAndSqueeze
  extend ActiveSupport::Concern
  def self.apply(var)
    var.strip.squeeze(' ') unless var.nil?
  end
end
