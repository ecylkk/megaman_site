class PagesController < ApplicationController
  STAGES = [
    { id: "spark",  name: "SPARK MAN",  subtitle: "项目经验", img: nil },
    { id: "snake",  name: "SNAKE MAN",  subtitle: "博客",     img: nil },
    { id: "needle", name: "NEEDLE MAN", subtitle: "技术栈",   img: nil },
    { id: "gemini", name: "GEMINI MAN", subtitle: "作品集",   img: nil },
    { id: "bomb",   name: "BOMB MAN",   subtitle: "小工具",   img: nil },
    { id: "aqua",   name: "AQUA MAN",   subtitle: "文章",     img: nil },
    { id: "leaf",   name: "LEAF MAN",   subtitle: "联系",     img: nil },
    { id: "flash",  name: "FLASH MAN",  subtitle: "彩蛋",     img: nil },
    { id: "kai",    name: "KAI",        subtitle: "关于我",   img: nil }
  ].freeze

  def select
    @stages = STAGES
    session[:cleared_stages] ||= []
    @cleared = session[:cleared_stages]
  end

  def stage
    id = params[:id]
    @stage = STAGES.find { |s| s[:id] == id } || { id: id, name: id.upcase, subtitle: "未设置", img: nil }
    if id == 'kai'
      prime_visitor_context_from_request
      @content = "# 『 Kai · The World 』\n\n\n所以，这就是我，Kai，正如你所见。"
      @comments = Comment.where(stage_id: 'kai').with_attached_image.order(created_at: :desc)
    else
      @content = "# #{@stage[:name]}\n\n这是 #{@stage[:subtitle]} 页面。这里以后会用 Markdown 写内容。"
      @comments = []
    end
  end

  def visitor_context
    return head :not_found unless params[:id] == "kai"

    session[:visitor_context] = {
      ip: params[:ip].to_s.strip.presence,
      location: params[:location].to_s.strip.presence,
      user_agent: request.user_agent.to_s,
      updated_at: Time.current.to_i
    }.compact

    head :ok
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

  private

  def prime_visitor_context_from_request
    session[:visitor_context] ||= {}

    server_ip = request.remote_ip.to_s.strip.presence
    session[:visitor_context]["ip"] ||= server_ip
    session[:visitor_context]["user_agent"] ||= request.user_agent.to_s
    session[:visitor_context]["updated_at"] = Time.current.to_i

    return if session[:visitor_context]["location"].present?
    return if server_ip.blank? || local_ip?(server_ip)

    location = fetch_location_from_ip(server_ip)
    session[:visitor_context]["location"] = location if location.present?
  rescue StandardError => e
    Rails.logger.warn("Visitor context bootstrap failed for #{server_ip}: #{e.class} #{e.message}")
  end

  def fetch_location_from_ip(ip)
    response = Net::HTTP.get_response(URI("https://ipapi.co/#{ip}/json/"))
    return unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    return if data["error"]

    [data["city"], data["region"], data["country_name"]].filter_map(&:presence).join(" / ").presence
  end

  def local_ip?(ip)
    ip == "127.0.0.1" || ip == "::1" || ip.start_with?("192.168.", "10.") || ip.match?(/\A172\.(1[6-9]|2\d|3[0-1])\./)
  end
end
