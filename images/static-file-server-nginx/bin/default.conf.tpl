server {
  listen       ${PUBLIC_PORT};
  server_name  ${PUBLIC_HOST};

  ${SSL_PLACEHOLDER}

  access_log /dev/stdout;
  error_log /dev/stdout debug;

  location ~ / {
    ${HTPASSWD_PLACEHOLDER}
    autoindex on;

    root ${SERVED_PATH};
  }
}