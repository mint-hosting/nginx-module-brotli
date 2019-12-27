Brotli module for Nginx
-----------------

This repository provides access to the Brotli dynamic module for nginx, so it can be dynamically loaded into Nginx configuration. The module is compiled on the following systems:
- Ubuntu 18.04
- Ubuntu 19.04
- Ubuntu 19.10
- Debian 9
- Debian 10

Tags represent stable Nginx version for which module is being compiled.

Installation
-----------------
1. Download module for you version of nginx and put it into `modules` directory (uslually `/usr/lib/nginx/modules`).
2. Put the load_module directives in the top‑level (“main”) context of nginx file, `nginx.conf`:
```
load_module /usr/lib/nginx/modules/ngx_http_brotli_filter_module.so;
load_module /usr/lib/nginx/modules/ngx_http_brotli_static_module.so;
```
1. Perform additional configuration as required by the [module](https://github.com/google/ngx_brotli)
2. Test new configuration and reload nginx server:
```
nginx -t && nginx -s reload
```

More Information
-----------------
- [NGINX Module for Brotli Compression Reference](https://github.com/google/ngx_brotli)
- [NGINX Dynamic Modules](https://docs.nginx.com/nginx/admin-guide/dynamic-modules/dynamic-modules/)

License
-----------------
GNU General Public License v3.0 or later

Authors
-----------------
This repo is maintained by Igor Hrček <igor.hrcek@mint.rs>