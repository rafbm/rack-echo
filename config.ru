run proc { |env|
  request = Rack::Request.new(env)

  response = ''
  response << "Remote IP: #{request.ip}\r\n\r\n"

  request.each_header do |key, value|
    next if !key.start_with?('HTTP_')

    key = key.delete_prefix('HTTP_').split('_').map(&:capitalize).join('-')
    response << "#{key}: #{value}\r\n"
  end

  response << env['rack.input'].read

  puts response

  [200, { 'Content-Type' => 'text/plain' }, [response]]
}
