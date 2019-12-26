Brotli module for Nginx
-----------------

This repository provides access to the Brotli dynamic module for nginx, so it can be dynamically loaded into Nginx configuration. The module is compiled inside Ubuntu 18.04 Docker container (glibc 2.27).

Tags represent stable Nginx version for which module is being compiled. 

Installation
-----------------
1. Download module for you version of nginx and put it into `modules` directory (uslually `/usr/lib/nginx/modules`).
2. Put the load_module directives in the top‑level (“main”) context of nginx file, `nginx.conf`:
```
load_module /usr/lib/nginx/modules/ngx_http_brotli_filter_module.so;
load_module /usr/lib/nginx/modules/ngx_http_brotli_static_module.so;
```
3. Perform additional configuration as required by the [https://github.com/google/ngx_brotli](module)
4. Test new configuration and reload nginx server:
```
nginx -t && nginx -s reload
```

More Information
-----------------
- [https://github.com/google/ngx_brotli](NGINX Module for Brotli Compression Reference)
- [https://docs.nginx.com/nginx/admin-guide/dynamic-modules/dynamic-modules/] NGINX Dynamic Modules

License
-----------------
GNU General Public License v3.0 or later

Authors
-----------------
This repo is maintained by Igor Hrček <igor.hrcek@mint.rs>