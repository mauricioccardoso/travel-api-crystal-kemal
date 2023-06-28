FROM crystallang/crystal:1.8.2

RUN apt update && apt install -y wget ncat

RUN wget -q -O /usr/bin/wait-for https://raw.githubusercontent.com/eficode/wait-for/v2.2.3/wait-for && \
    chmod +x /usr/bin/wait-for

RUN useradd -m crystal

USER crystal

WORKDIR /home/crystal/app/backend

COPY ./.bash_aliases /home/crystal

EXPOSE 3000

CMD [ "crystal", "src/main.cr" ]