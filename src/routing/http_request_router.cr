require "./base"

module Routing
  module HttpRequestRouter
    macro included
      include Routing::Base

      def should_process?(request, pattern, options)
        request.method == options[:via] && should_process_path?(request.path[1..-1], pattern)
      end
    end

    macro route_exec(mapping)
      {% receiver_and_message = mapping.split '#' %}
      {% receiver = receiver_and_message[0] %}
      {% message = receiver_and_message[1] %}
      with_context({{receiver.id.capitalize}}Controller.new).{{message.id}}
    end

    macro get(pattern, mapping)
      append_route({{pattern}}, {{mapping}}, {via: "GET"})
    end

    macro post(pattern, mapping)
      append_route({{pattern}}, {{mapping}}, {via: "POST"})
    end

    macro root(mapping)
      append_route("", {{mapping}}, {via: "GET"})
    end
  end
end
