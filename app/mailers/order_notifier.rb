class OrderNotifier < ActionMailer::Base
default from: 'Sundar TCS <depot@example.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped
    @greeting = "Hi"

    mail to: "to@example.org"
  end
def received(order)
	@order = order
	mail to: order.email, subject: 'Roaring-ROR Order Confirmation'
end
def shipped(order)
	@order = order
	mail to: order.email, subject: 'Roaring-ROR Order Shipped'
end
end
