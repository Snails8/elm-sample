FROM node:17.0.1-buster-slim

WORKDIR /src

RUN apt update && \
apt-get install sudo && \
yes | sudo apt install curl && \
curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz && \
gunzip elm.gz && \
chmod +x elm && \
sudo mv elm /usr/local/bin/ && \
npm install --save elm elm-live && \
sed -i -e "s/\(ignoreInitial: true,\)/\1\n    usePolling: true, /g" /src/node_modules/elm-live/lib/src/watch.js

ENV PATH $PATH:/usr/local/bin

CMD /src/node_modules/.bin/elm-live /src/portfolio/src/Main.elm --start-page=index.html --host=0.0.0.0 -- --output=elm.js