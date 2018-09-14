FROM rdebourbon/docker-base:latest
MAINTAINER rdebourbon@xpandata.net

# add our user and group first to make sure their IDs get assigned regardless of what other dependencies may get added.
RUN groupadd -r librarian && useradd -r -g librarian librarian

RUN apt-get -q update && \
    apt-get install -qy --force-yes python-pip build-essential python2.7 && \
    git clone https://github.com/BitBotFactory/poloniexlendingbot /PoloniexLendingBot && \
    pip install --no-cache-dir -r /PoloniexLendingBot/requirements.txt && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/tmp/* && \
    rm -rf /tmp/*

RUN mkdir -p /data && \
    chown -R librarian:librarian /PoloniexLendingBot && \
    chown -R librarian:librarian /data

VOLUME ["/data"]

WORKDIR /PoloniexLendingBot

RUN ln -s /data/market_data market_data; \
    ln -s /data/log/botlog.json www/botlog.json

EXPOSE 8100

USER librarian

CMD ["python", "/PoloniexLendingBot/lendingbot.py", "-cfg", "/data/conf/default.cfg"]