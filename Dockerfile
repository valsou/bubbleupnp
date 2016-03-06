FROM hypriot/rpi-java:latest

MAINTAINER Valentin Mezin <valentin.mezin@gmail.com>

# RUN echo "@community http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories; \
#	apk update && apk add openjdk7@community xfsprogs && \
#	wget -O /root/MinimServer-0.8.3f-linux-armhf.tar.gz http://jminim.com/cada/MinimServer-0.8.3f-linux-armhf.tar.gz && \
#	tar xf /root/MinimServer-0.8.3f-linux-armhf.tar.gz && \
#	rm /root/MinimServer-0.8.3f-linux-armhf.tar.gz

RUN apt-get update && apt-get install -y ffmpeg zip unzip

ADD http://www.bubblesoftapps.com/bubbleupnpserver/BubbleUPnPServer-distrib.zip /

RUN mkdir /data/BubbleUPnPServer && \
	cd /data/BubbleUPnPServer && \
	unzip /BubbleUPnPServer-distrib.zip && \
	rm /BubbleUPnPServer-distrib.zip && \
	chmod +x /data/BubbleUPnPServer/launch.sh

EXPOSE 1900/udp 58050/tcp 58051/tcp

COPY configuration.xml /data/BubbleUPnPServer/configuration.xml

ENTRYPOINT ["/data/BubbleUPnPServer/launch.sh"]
