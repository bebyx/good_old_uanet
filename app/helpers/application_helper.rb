module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end
  
  def markdown(text)
    raw Redcarpet::Markdown.new(AppMD.new(
      no_images: true, no_styles: true,
      filter_html: true, prettify: true, hard_wrap: true),
      autolink: true, space_after_headers: true,
      strikethrough: true, underline: true,
      superscript: true, no_intra_emphasis: true,
      tables: false, quote: false,
      disable_indented_code_blocks: true
    ).render(text)
  end
end

class AppMD < Redcarpet::Render::HTML
  def header(text, level)
    "<p>#{text}</p>"
  end
end
