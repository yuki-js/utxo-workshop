FROM rust:slim-stretch

WORKDIR /
RUN apt-get update && \
apt-get upgrade -y && \
apt-get install git build-essential libssl-dev pkg-config clang -y && \
rustup update nightly && \
rustup target add wasm32-unknown-unknown --toolchain nightly && \
rustup update stable && \
cargo install --git https://github.com/alexcrichton/wasm-gc

RUN git clone https://github.com/yuki-js/utxo-workshop
WORKDIR /utxo-workshop
RUN git fetch origin workshop:workshop && git checkout workshop
RUN ./build.sh
RUN cargo build
RUN cargo build --release

CMD ["bash"]
