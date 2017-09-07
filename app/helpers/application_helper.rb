module ApplicationHelper
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def my_devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map do |msg|
      content_tag(:div, msg, class: 'alert alert-danger')
    end.join

    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      #{messages}
    </div>
    HTML

    html.html_safe
  end

  def tooltip_widget(message_key)
    html = <<-HTML
    <em class="fa fa-info-circle info" data-toggle="tooltip" data-placement="top"
    data-original-title="#{ t("tooltips.races.#{message_key}") }"></em>
    HTML

    html.html_safe
  end

end
