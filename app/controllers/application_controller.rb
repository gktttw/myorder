class ApplicationController < ActionController::API
  private

  def trace_id
    @trace_id ||= Thread.current[:trace_id]
  end

  def render_json_response(data, status: :ok)
    render json: { data:, trace_id: }, status: status
  end
end
