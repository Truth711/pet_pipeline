FROM node:12.22 AS build
LABEL maintainer="massimo@it20.info"

WORKDIR /clarity-seed

RUN npm install -g @angular/cli@12.0.0 node-sass@4.14.1

COPY clarity-seed-newfiles/ ./clarity-seed-newfiles/

RUN git clone https://github.com/vmware/clarity-seed.git && \
WORKDIR clarity-seed
RUN git checkout -b f3250ee26ceb847f61bb167a90dc957edf6e7f43

COPY clarity-seed-newfiles/src ./clarity-seed/src/
COPY clarity-seed-newfiles/package.json ./clarity-seed/package.json
COPY clarity-seed-newfiles/angular-cli.json ./clarity-seed/.angular-cli.json

RUN rm -r ./clarity-seed/src/app/home && \
    rm -r ./clarity-seed/src/app/about

WORKDIR /clarity-seed/src
RUN npm install && \
    ng build --environment=prod --output-path=./prod/dist/ -aot -vc -cc -dop --buildOptimizer && \
    ng build --environment=test --output-path=./test/dist/ && \
    ng build --environment=dev --output-path=./dev/dist/

FROM nginx:1.17.10
LABEL maintainer="massimo@it20.info"

WORKDIR /
COPY startup.sh ./startup.sh
ENV UI_ENV=prod
RUN chmod +x startup.sh

COPY --from=build /clarity-seed/src/prod/dist /clarity-seed/prod/dist
COPY --from=build /clarity-seed/src/test/dist /clarity-seed/test/dist
COPY --from=build /clarity-seed/src/dev/dist /clarity-seed/dev/dist

CMD ["./startup.sh"]
