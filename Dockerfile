FROM node:14-alpine
MAINTAINER <ilyabukalov@gmail.com>

ENV HOME=/home/datacraft-chain
EXPOSE 8545

WORKDIR $HOME
ADD . $HOME

RUN apk add --no-cache git bash make g++ geth
RUN npm install
# download the correct solc compiler
RUN npm run compile

# CMD $HOME/scripts/run_local_network.sh
