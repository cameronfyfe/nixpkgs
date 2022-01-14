{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "ets";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "zmwangx";
    repo = pname;
    rev = version;
    sha256 = "sha256-ceRyYrqmgdTnV8m9LkLlR6iTrC5F81X/V3fWI2CiKBw=";
  };

  vendorSha256 = "sha256-UCeMy4iT0c2sTcCDPg0TIYCLYfrIUvHluUuGIpzluSg=";

  doCheck = false;

#   ldflags = [ "-s" "-w" "-X main.version=${version}" "-X main.build=v${version}" ];

  meta = with lib; {
    description = "Command output timestampe";
    homepage = "https://github.com/zmwangx/ets/";
    license = licenses.mit;
    maintainers = with maintainers; [ cameronfyfe ];
  };
}
