module ApplicationHelper
  # 显示序号
  def show_index(index, per=params[:per])
    return (index + 1) unless per
    params[:page] ||= 1
    (params[:page].to_i - 1) * per + index + 1
  end

  # 必须项，红星
  def require_span
    "<span class='red'>* </span>".html_safe
  end

  def link_to_back(opts = {}, html_opts = {})
    opts[:title] ||= '返回'
    link_to_btn title: opts[:title], size: 'btn-small', url: opts[:url]
  end

  def link_to_btn(opts = {}, html_opts = {})
    title = opts[:title] || 'title'
    size = opts[:size] || 'btn-big'
    btn_style = opts[:btn_style] || ''
    style = {class: "btn btn-#{btn_style} ml5 " + size}.merge(html_opts)
    return link_to title, opts[:url], style if opts[:url]
    # link_to_function(title, 'history.go(-1)', style)
  end

end
