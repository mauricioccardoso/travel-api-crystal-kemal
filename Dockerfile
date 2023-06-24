FROM crystallang/crystal:1.8.2

RUN useradd -m crystal

USER crystal

WORKDIR /home/crystal/app

COPY ./.bash_aliases /home/crystal

EXPOSE 3000

CMD [ "tail", "-f", "/dev/null" ]
# CMD [ "crystal", "run", "src/main.cr" ]