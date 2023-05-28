FROM alpine:3.18
RUN apk add --no-cache fish py3-unidecode fzf jq curl
COPY lastfm-to-gonic unidecode /

ENV LFM_USER=
ENV LFM_API_KEY=

VOLUME [ "/music", "/playlists" ]

COPY <<EOF /entrypoint
#!/bin/sh
while true; do
    find /music -type f \\( -name \'*.mp3\' -o -name \'*.flac\' \\) | /lastfm-to-gonic \$LFM_USER \$LFM_API_KEY >/playlists/lastfm.m3u
    sleep 3600
done
EOF

RUN chmod +x /entrypoint
CMD ["/entrypoint"]
