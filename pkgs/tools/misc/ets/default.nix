{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "ets";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "zmwangx";
    repo = pname;
    rev = version;
    sha256 = "sha256-XWIDo5msTMTLr60x1R9cwsiZIDG6G+uHWx8idt4F2iA=";
  };

  vendorSha256 = null;

  doCheck = false;

#   ldflags = [ "-s" "-w" "-X main.version=${version}" "-X main.build=v${version}" ];

  meta = with lib; {
    description = "Command output timestamp";
    homepage = "https://github.com/zmwangx/ets/";
    license = licenses.mit;
    maintainers = with maintainers; [ cameronfyfe ];
  };
}
