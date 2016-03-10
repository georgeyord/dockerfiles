server {
  listen       ${PUBLIC_PORT};
  server_name  ${PUBLIC_HOST};

  ${SSL_PLACEHOLDER}

  access_log /dev/stdout;
  error_log /dev/stdout debug;

  location ~ / {
    ${HTPASSWD_PLACEHOLDER}
    ${WEBSOCKET_PLACEHOLDER}

    proxy_pass http://${TARGET_HOST}:${TARGET_PORT};
    proxy_pass_request_headers on;
    proxy_redirect     default;
    proxy_set_header   Host              $http_host;
    proxy_set_header   X-Real-IP         $remote_addr;
    proxy_set_header   X-Forwarded-For   $proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Proto $scheme;
    proxy_max_temp_file_size 0;

    #this is the maximum upload size
    client_max_body_size       10m;
    client_body_buffer_size    128k;

    proxy_connect_timeout      90;
    proxy_send_timeout         90;
    proxy_read_timeout         90;
    proxy_buffer_size          4k;
    proxy_buffers              4 32k;
    proxy_busy_buffers_size    64k;
    proxy_temp_file_write_size 64k;
  }
}