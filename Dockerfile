FROM fluent/fluentd:v1.9.3-debian-1.0

USER root

RUN buildDeps='sudo make gcc g++ libc-dev' \
    && apt-get update \
    && apt-get install --yes --no-install-recommends $buildDeps \
    && sudo gem install fluent-plugin-elasticsearch         --version 4.0.6 \
    && sudo gem install fluent-plugin-record-modifier       --version 2.1.0 \
    && sudo gem install fluent-plugin-rewrite-tag-filter    --version 2.2.0 \
    && sudo gem install fluent-plugin-prometheus            --version 1.7.3 \
    && sudo gem sources --clear-all \
    && SUDO_FORCE_REMOVE=yes \
        apt-get purge --yes --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

USER fluent
