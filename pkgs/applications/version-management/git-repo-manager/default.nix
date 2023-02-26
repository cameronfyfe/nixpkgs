{ lib
, stdenv
, callPackage
, makeRustPlatform
, fetchFromGitHub
, fetchpatch
, openssl
, pkg-config
}:

let

  pname = "git-repo-manager";
  version = "0.7.12";

  src = fetchFromGitHub {
    owner = "hakoerber";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-FFzarNPI3GYjt98cAcypxDN53Nl372b7KYA4tUCbD7Y=";
  };

  # TODO: use fetchFromGitHub directly once this PR is merged
  # https://github.com/mozilla/nixpkgs-mozilla/pull/303/
  mozillaOverlay = stdenv.mkDerivation {
    name = "nixpkgs-mozilla";
    src = fetchFromGitHub {
      owner = "mozilla";
      repo = "nixpkgs-mozilla";
      rev = "85eb0ba7d8e5d6d4b79e5b0180aadbdd25d76404";
      sha256 = "sha256-ZAJGIZ7TjOCU7302lSUabNDz+rxM4If0l8/ZbE/7R5U=";
    };
    buildPhase = ''
      cp -ar $src patched
      chmod +w patched/rust-overlay.nix
      sed 's/header/echo/g' $src/rust-overlay.nix > patched/rust-overlay.nix
      chmod +w patched/rust-overlay.nix
    '';
    installPhase = ''
      cp -ar patched $out
    '';
  };

  mozilla = callPackage "${mozillaOverlay.out}/package-set.nix" { };

  # TODO: define this based on the rust-toolchain file once next grm version is tagged
  rust = (mozilla.rustChannelOf {
    channel = "nightly";
    date = "2023-02-25";
    sha256 = "sha256-uLFgqCLudpypnhz3+kMivOgJzaFa74xvUEpphyTYibw=";
  }).rust;

  rustPlatform = makeRustPlatform {
    cargo = rust;
    rustc = rust;
  };

in

rustPlatform.buildRustPackage rec {
  inherit pname version src;

  cargoSha256 = "sha256-lDEzB4x++TqhjKbeMfPscl+tGmxfDYp8mLGHkZPvras=";

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [ openssl ];

  meta = with lib; {
    description = "A git tool to manage worktrees and integrate with GitHub and GitLab";
    homepage = "https://github.com/hakoerber/${pname}";
    license = licenses.gpl3;
    maintainers = with maintainers; [ cameronfyfe ];
  };
}
