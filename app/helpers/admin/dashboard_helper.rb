module Admin::DashboardHelper
  def admin_header_link(text, path)
    li_classes = []
    li_classes << 'active' if current_page? path

    content_tag(:li,
      content_tag(:a, text, href: path,
      data: { toggle: 'tag' }), class: li_classes.join(' '))
  end
end
