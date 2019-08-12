#############################################################################
#                               Rancher                                     #
#############################################################################
server {
    listen            80;
    listen       [::]:80;
    server_name  rancher.yphanikumar.xyz;

    location / {
   # resolver kube-dns.kube-system.svc.cluster.local ipv6=off;
    set $target https://rancher:443;
    proxy_pass  $target;
    proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
    proxy_redirect off;
    proxy_buffering off;
    proxy_set_header        Host            $host;
    proxy_set_header        X-Real-IP       $remote_addr;
    proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
   }
  # force https-redirects
    if ($http_x_forwarded_proto = 'http'){
    return 301 https://$host$request_uri;
    }
}
