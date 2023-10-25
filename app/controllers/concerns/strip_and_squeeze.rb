module StripAndSqueeze
  extend ActiveSupport::Concern
  def self.apply(var)
    return var.strip.squeeze(' ') unless var.nil?
    ""
  end
end
