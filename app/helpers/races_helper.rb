module RacesHelper

  def race_progress_bar(race)
    perc = race.completed_percentage.to_i
    color = race_complete_color(perc)

    html = <<-HTML
      <div data-toggle="tooltip" data-title="Obbiettivo raggiunto al #{perc}%">
         <div class="progress m0">
            <div style="width:#{perc}%"  class="progress-bar progress-bar-striped progress-bar-#{color}"><span>#{perc}%</span></div>
         </div>
      </div>
    HTML

    html.html_safe
  end

  def race_complete_color(perc)
    if perc >= 50 and perc < 80
      "info"
    elsif perc >= 80
      "success"
    else
      "default"
    end
  end

  def likes_counter_widget(likes)
    html = <<-HTML
          <button id="likes_counter" type="button" class="btn btn-default btn-xs disabled">
            <em class="fa fa-thumbs-up text-info"></em>
            <span>#{likes}</span>
          </button>

    HTML
    html.html_safe
  end

  def likes_button_widget(user_id,race_id,likes)
    html = <<-HTML
        <button id="add_like_button" type="button" class="btn btn-info btn-xs"
                data-race="#{race_id}" data-user="#{user_id}" data-likes="#{likes}">
        <em class="fa fa-thumbs-up "></em>
            <span>Mi piace</span>
        </button>
    HTML


    html.html_safe
  end

  def race_kind_icon(kind)
    if kind == :open
      icon_prop = "fa fa-3x fa-users text-success"
    else
      icon_prop = "fa fa-3x fa-users text-warning"
    end

    html = <<-HTML
     <em class="#{icon_prop}"></em>
    HTML

    html.html_safe
  end

end
