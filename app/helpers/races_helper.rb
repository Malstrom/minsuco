module RacesHelper

  def race_progress_bar(race)
    perc = race.completed_percentage.to_i
    color = race_complete_color(perc)

    html = <<-HTML

      <div data-toggle="tooltip" data-title="Gara completa al #{perc}%">
         <div class="progress m0">
            <div style="width:#{perc}%" class="progress-bar progress-bar-striped progress-bar-#{color}"></div>
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
end
