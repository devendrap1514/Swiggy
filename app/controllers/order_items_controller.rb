class OrderItemsController < AuthenticationController
  before_action :is_customer?
end
