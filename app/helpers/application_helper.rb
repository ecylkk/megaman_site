# app/helpers/application_helper.rb
module ApplicationHelper
  def markdown(text)
    # 设置 HTML 渲染器，过滤 HTML 并自动换行
    renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
    
    # 配置 Markdown 解析器的扩展功能
    md = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true, tables: true, autolink: true)
    
    # 渲染 Markdown 并标记为 HTML 安全
    md.render(text).html_safe
  end
end
