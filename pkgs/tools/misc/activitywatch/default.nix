{ stdenv
, callPackage
, darwin
, fetchFromGitHub
, fetchurl
, killall
, llvmPackages_14
, makeRustPlatform
, writeShellScript
}:

let

  version = "0.11.0";

  src = fetchFromGitHub {
    owner = "ActivityWatch";
    repo = "activitywatch";
    rev = "v${version}";
    fetchSubmodules = true;
    sha256 = "izRR5Ik7eyE35q2hKwgSSkjNmdLZEog/QMmEopeKoRA=";
  };

  py-libs = callPackage ./py-libs.nix { };

  aw-core = callPackage ./aw-core.nix { } {
    src = "${src}/aw-core";
    inherit version py-libs;
  };

  aw-client = callPackage ./aw-client.nix { } {
    src = "${src}/aw-client";
    inherit version py-libs aw-core;
  };

  aw-watcher-afk = callPackage ./aw-watcher-afk.nix { } {
    src = "${src}/aw-watcher-afk";
    inherit version py-libs aw-client;
  };

  aw-watcher-window = callPackage ./aw-watcher-window.nix { } {
    src = "${src}/aw-watcher-window";
    inherit version py-libs aw-client;
  };

  aw-webui = ./aw-webui;

  aw-server = callPackage ./aw-server.nix { } {
    src = "${src}/aw-server";
    inherit version py-libs aw-client aw-webui;
  };

  aw-start = writeShellScript "aw-start" ''
    ${aw-server}/bin/aw-server &
    ${aw-watcher-afk}/bin/aw-watcher-afk &
    ${aw-watcher-window}/bin/aw-watcher-window &

    # stay alive
    while true; do sleep 60; done
  '';

  aw-stop = writeShellScript "aw-stop" ''
    for P in .aw-server-wrap .aw-watcher-afk .aw-watcher-win aw-start; do
      ${killall}/bin/killall $P
    done
  '';

in

stdenv.mkDerivation {
  name = "activitywatch";
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin
    cp ${aw-start} $out/bin/aw-start
    cp ${aw-stop} $out/bin/aw-stop
  '';
}
