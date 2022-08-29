function my-local-ip
    ip route get 1.1.1.1 | perl -lne 'print for /src (\K\S+)/'
end
