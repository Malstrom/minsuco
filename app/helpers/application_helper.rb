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

  def tooltip_widget(thing,message_key)
    html = <<-HTML
    <em class="fa fa-info-circle info text-muted" data-toggle="tooltip" data-placement="top"
    data-original-title="#{ t("tooltips.#{thing}.#{message_key}") }"></em>
    HTML

    html.html_safe
  end

  def notice_widget(event_id, icon, who_did, message, thing_name )
    html = <<-HTML
      <a href="#{readed_path(event_id)}" class="list-group-item" id="readed_join_in_race">
        <div class="media-box">
            <div class="pull-left">
              <em class="fa #{icon} fa-2x text-success"></em>
            </div>
          <div class="media-box-body clearfix">
            <p class="m0"></p>
            <p class="m0 text-muted">
              <small>#{I18n.t("messages.#{message}", who_did: who_did, race_name:thing_name)}</small>
            </p>
          </div>
        </div>
      </a>
    HTML
    html.html_safe
  end

end
