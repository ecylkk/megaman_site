class PagesController < ApplicationController
  STAGES = [
    { id: "spark",  name: "SPARK MAN",  subtitle: "项目经验", img: nil },
    { id: "snake",  name: "SNAKE MAN",  subtitle: "博客",     img: nil },
    { id: "needle", name: "NEEDLE MAN", subtitle: "技术栈",   img: nil },
    { id: "gemini", name: "GEMINI MAN", subtitle: "作品集",   img: nil },
    { id: "shadow", name: "SHADOW MAN", subtitle: "关于我",   img: nil },
    { id: "bomb",   name: "BOMB MAN",   subtitle: "小工具",   img: nil },
    { id: "aqua",   name: "AQUA MAN",   subtitle: "文章",     img: nil },
    { id: "leaf",   name: "LEAF MAN",   subtitle: "联系",     img: nil },
    { id: "flash",  name: "FLASH MAN",  subtitle: "彩蛋",     img: nil }
  ].freeze

  def select
    @stages = STAGES
    session[:cleared_stages] ||= []
    @cleared = session[:cleared_stages]
  end

  def stage
    id = params[:id]
    @stage = STAGES.find { |s| s[:id] == id } || { id: id, name: id.upcase, subtitle: "未设置", img: nil }
    @content = "# #{@stage[:name]}\n\n这是 #{@stage[:subtitle]} 页面。这里以后会用 Markdown 写内容。"
  end

  # POST /clear_stage
  def clear_stage
    id = params[:stage_id]
    session[:cleared_stages] ||= []

    if id == '__clear_all__'
      session[:cleared_stages] = []
    elsif id.present?
      session[:cleared_stages] << id unless session[:cleared_stages].include?(id)
    end

    head :ok
  end
end
