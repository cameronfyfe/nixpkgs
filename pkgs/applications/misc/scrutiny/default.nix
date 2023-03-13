{ lib
, buildGoModule
, fetchFromGitHub
, smartmontools
}:

buildGoModule rec {
  pname = "scrutiny";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "AnalogJ";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-zkw+41UJRXi3eQO4YEMq8iAqhFjTTMyinLGCBN4Oc0Y=";
  };

  vendorSha256 = "sha256-eB2Zmd537psC0QU2SkWlamLC5qw0HwFo4IxWgQXfxmQ=";

  postBuild = ''
    getMakeVar() {
      grep -m 1 $1 Makefile | sed 's/^.*= //g'
    }
    COLLECTOR_BINARY_NAME=$(getMakeVar COLLECTOR_BINARY_NAME)
    WEB_BINARY_NAME=$(getMakeVar WEB_BINARY_NAME)

    bin=$GOPATH/bin
    mv $bin/collector-metrics $bin/$COLLECTOR_BINARY_NAME
    mv $bin/scrutiny $bin/$WEB_BINARY_NAME
  '';

  buildInputs = [ smartmontools ];

  doCheck = false;

  meta = with lib; {
    description = "Hard Drive S.M.A.R.T Monitoring, Historical Trends & Real World Failure Thresholds";
    homepage = "https://github.com/AnalogJ/scrutiny/";
    license = licenses.mit;
    maintainers = with maintainers; [ cameronfyfe ];
  };
}
