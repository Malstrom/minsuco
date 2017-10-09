module DashboardHelper
  def no_chart_widget(icon = "fa-area-chart")
    html = <<-HTML
      <div class="text-center">
        <br>
        <br><br>
        <p class="lead text-muted">Dati insufficenti per il grafico</p>
        <br><br>
        <em class="fa #{icon} fa-5x text-gray"></em>
        <br><br><br><br><br><br>
      </div>
    HTML

    html.html_safe
  end
end
