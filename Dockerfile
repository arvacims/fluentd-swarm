FROM fluent/fluentd:v1.4.2-debian-1.0

USER root

RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev" \
    && apt-get update \
    && apt-get install -y --no-install-recommends $buildDeps \
    && sudo gem install fluent-plugin-elasticsearch         --version 3.4.2 \
    && sudo gem install fluent-plugin-record-modifier       --version 2.0.1 \
    && sudo gem install fluent-plugin-rewrite-tag-filter    --version 2.2.0 \
    && sudo gem sources --clear-all \
    && SUDO_FORCE_REMOVE=yes \
        apt-get purge -y --auto-remove \
        -o APT::AutoRemove::RecommendsImportant=false \
        $buildDeps \
    && rm -rf \
        /var/lib/apt/lists/* \
        /home/fluent/.gem/ruby/2.3.0/cache/*.gem

USER fluent
