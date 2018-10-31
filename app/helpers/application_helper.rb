module ApplicationHelper
  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", errors: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    if flash.present?
      content_tag(:div, class: 'section-alert') do
        flash.each do |msg_type, message|
          concat(content_tag(:div, message, class: "alert-publisher alert #{bootstrap_class_for(msg_type)} alert-dismissible", role: 'alert') do
            concat(content_tag(:button, class: 'close', data: { dismiss: 'alert' }) do
              concat content_tag(:span, '&times;'.html_safe, 'aria-hidden' => true)
              concat content_tag(:span, 'Close', class: 'sr-only')
            end)
            if flash[:errors].present?
              message.each do |word|
                concat "<div class='alert alert-success alert-dismissible'>#{word}</div>".html_safe
              end
            else
              concat "#{message}".html_safe
            end
          end)
        end
        nil
      end
    end
  end

  def active_sidebar?(controller, *actions)
    if actions.include?(params[:action].to_sym) || actions.include?(:all)
      return 'active'
    end if controller_name == controller.to_s
  end

  def get_date(datetime)
    datetime.strftime(" %d-%m-%y ")
  end
end
