fn main() {
    tonic_build::configure()
        .build_server(true)
        .compile_protos(
            &["/Users/annakarenina/develop/github.com/Anna-Karenina/ssme/proto/api.proto"],
            &["/Users/annakarenina/develop/github.com/Anna-Karenina/ssme/proto"],
        )
        .unwrap();
}
