require "net/http"
require "json"

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.stage_id = params[:stage_id] || 'kai'

    visitor_context = session[:visitor_context].is_a?(Hash) ? session[:visitor_context] : {}
    context_ip = visitor_context["ip"] || visitor_context[:ip]
    context_location = visitor_context["location"] || visitor_context[:location]

    client_ip = params[:public_ip].presence || context_ip.presence || request.remote_ip
    @comment.ip_address = client_ip

    # 優先順序：本次表單 → 進入 kai 時存到 session 的訪客資訊 → 後端用 IP 查詢
    @comment.location = normalize_location(params[:public_location])
    @comment.location ||= normalize_location(context_location)
    @comment.location ||= fetch_location_from_ip(client_ip)
    @comment.location ||= infer_region_from_headers
    @comment.location ||= "Location unavailable"

    # 使用 browser gem 解析设备信息
    user_browser = Browser.new(request.user_agent)
    @comment.device_info = "#{user_browser.platform.name} / #{user_browser.name}"

    if @comment.save
      redirect_to stage_path(@comment.stage_id), notice: '留言成功！'
    else
      redirect_to stage_path(params[:stage_id] || 'kai'), alert: '留言失败，请填写内容。'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :image)
  end

  def normalize_location(raw_location)
    raw_location.to_s.strip.presence
  end

  def fetch_location_from_ip(ip)
    return if ip.blank? || local_ip?(ip)

    response = Net::HTTP.get_response(URI("https://ipapi.co/#{ip}/json/"))
    return unless response.is_a?(Net::HTTPSuccess)

    data = JSON.parse(response.body)
    return if data["error"]

    [data["city"], data["region"], data["country_name"]].filter_map(&:presence).join(" / ").presence
  rescue StandardError => e
    Rails.logger.warn("IP location lookup failed for #{ip}: #{e.class} #{e.message}")
    nil
  end

  def infer_region_from_headers
    candidates = [
      request.headers["CF-IPCountry"],
      request.headers["HTTP_CF_IPCOUNTRY"],
      request.headers["X-Appengine-Country"],
      request.headers["HTTP_X_APPENGINE_COUNTRY"]
    ].filter_map { |value| value.to_s.strip.presence }

    candidates.find { |value| value.match?(/\A[A-Z]{2}\z/) || value.length > 2 }
  end

  def local_ip?(ip)
    ip == "127.0.0.1" || ip == "::1" || ip.start_with?("192.168.", "10.") || ip.match?(/\A172\.(1[6-9]|2\d|3[0-1])\./)
  end
end
