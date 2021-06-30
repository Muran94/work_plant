module ApplicationHelper
  # 4620 -> ¥4,620
  def format_payment(payment)
    %(¥#{payment.to_s(:delimited)})
  end
end
