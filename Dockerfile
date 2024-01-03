FROM circleci/node:14-stretch
MAINTAINER "Manojvv" "manojv@ilimi.in"
USER root
COPY src /opt/content/
WORKDIR /opt/content/
RUN npm install --unsafe-perm

FROM node:14-slim
MAINTAINER "Manojvv" "manojv@ilimi.in"
RUN sed -i '/buster-updates/d' /etc/apt/sources.list \
    && apt update \
    && apt-get clean \
    && useradd -m sunbird
USER sunbird
COPY --from=0 --chown=sunbird /opt/content /home/sunbird/mw/content
WORKDIR /home/sunbird/mw/content/
CMD ["node", "app.js", "&"]
