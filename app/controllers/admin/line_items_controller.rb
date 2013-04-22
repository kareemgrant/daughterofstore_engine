module Admin
  class LineItemsController < ActionController::Base
    def increase_quantity
      li = LineItem.find(params[:id])
      li.update_attributes(:quantity => li.quantity + 1)
      redirect_to store_admin_order_path(li.order.store, li.order)
    end
    def decrease_quantity
      li = LineItem.find(params[:id])
      li.update_attributes(:quantity => li.quantity - 1)
      redirect_to store_admin_order_path(li.order.store, li.order)
    end
  end
end