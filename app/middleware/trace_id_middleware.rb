# frozen_string_literal: true

class TraceIdMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    trace_id = request.get_header("HTTP_X_TRACE_ID") || SecureRandom.uuid

    Thread.current[:trace_id] = trace_id
    Rails.logger.info("[TRACE_ID: #{trace_id}] Incoming request: #{request.request_method} #{request.fullpath}")

    status, headers, response = @app.call(env)

    # Ensure trace_id is included in response headers
    headers["X-Trace-ID"] = trace_id

    [status, headers, response]
  ensure
    Thread.current[:trace_id] = nil  # Clear trace_id after request
  end
end
