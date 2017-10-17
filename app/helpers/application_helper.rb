module ApplicationHelper
  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def my_devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map do |msg|
      content_tag(:div, msg, class: 'alert alert-danger')
    end.join

    sentence = I18n.t('errors.messages.not_saved',
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      #{messages}
    </div>
    HTML

    html.html_safe
  end

  def system_notice_widget
    html = ''
    flash.each do |key, value|
      key = 'info' if key == 'notice'
      key = 'danger' if key == 'alert'
      html << <<-HTML
        <a>
          <div id="notice" data-notify="" data-message=" #{value}" data-onload="true" data-options="{&quot;status&quot;:&quot;#{key}&quot;}"></div>
        </a>
      HTML
    end
    html.html_safe
  end

  def tooltip_widget(thing, message_key, prop = nil, icon = 'fa-info-circle')
    html = <<-HTML
    <em class="fa info text-muted #{prop} #{icon}" data-toggle="tooltip" data-placement="top"
    data-original-title="#{t("tooltips.#{thing}.#{message_key}")}"></em>
    HTML

    html.html_safe
  end

  def notice_widget(event_id, icon, who_did, message, thing_name)
    html = <<-HTML
      <a href="#{readed_path(event_id)}" class="list-group-item" id="readed_join_in_race">
        <div class="media-box">
            <div class="pull-left">
              <em class="fa #{icon} fa-2x text-success"></em>
            </div>
          <div class="media-box-body clearfix">
            <p class="m0"></p>
            <p class="m0 text-muted">
              <small>#{I18n.t("messages.#{message}", who_did: who_did, race_name: thing_name)}</small>
            </p>
          </div>
        </div>
      </a>
    HTML
    html.html_safe
  end

  def color_percentual(perc)
    if perc >= 50 && perc < 80
      'info'
    elsif perc >= 80
      'success'
    else
      'default'
    end
  end

  def image_profile_widget(id)
    user = User.find(id)
    if user[:image]
      html = <<-HTML
      <img src="#{ image_path(user.image) }" alt="Avatar" width="100" height="100" class="img-thumbnail img-circle" />
      HTML
      html.html_safe
    else
      image_tag("default_profile.png", alt:"Avatar", width: '60', height:"60", class:"img-thumbnail img-circle")
    end
  end
end
