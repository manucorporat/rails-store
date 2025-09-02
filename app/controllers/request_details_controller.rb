class RequestDetailsController < ApplicationController
  def index
    @request_details = {
      method: request.method,
      url: request.url,
      original_url: request.original_url,
      path: request.path,
      query_string: request.query_string,
      host: request.host,
      host_with_port: request.host_with_port,
      port: request.port,
      scheme: request.scheme,
      remote_ip: request.remote_ip,
      user_agent: request.user_agent,
      referer: request.referer,
      origin: request.headers['Origin'],
      content_type: request.content_type,
      content_length: request.content_length,
      headers: request.headers.to_h,
      params: params.to_unsafe_h,
      body: request.body.read,
      cookies: request.cookies,
      session: session.to_h,
      env_variables: request.env.select { |k, v| k.is_a?(String) && !k.start_with?('rack.') }
    }
    
    # Reset body position for potential future reads
    request.body.rewind if request.body.respond_to?(:rewind)
  end
end
