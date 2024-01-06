{ lib
, buildGoModule
, fetchFromGitHub
, makeWrapper
, smartmontools
}:

buildGoModule rec {
  pname = "scrutiny";
  version = "0.7.2";

  src = fetchFromGitHub {
    owner = "AnalogJ";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-UYKi+WTsasUaE6irzMAHr66k7wXyec8FXc8AWjEk0qs=";
  };

  vendorHash = "sha256-SiQw6pq0Fyy8Ia39S/Vgp9Mlfog2drtVn43g+GXiQuI=";

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ smartmontools ];

  postFixup = ''
    wrapProgram $out/bin/scrutiny-collector-metrics \
      --set PATH ${lib.makeBinPath [
        smartmontools
      ]}
  '';

  preInstall = ''
    getMakeVar() {
      grep -m 1 $1 Makefile | sed 's/^.*= //g'
    }
    COLLECTOR_BINARY_NAME=$(getMakeVar COLLECTOR_BINARY_NAME)
    WEB_BINARY_NAME=$(getMakeVar WEB_BINARY_NAME)

    bin=$GOPATH/bin
    mv $bin/collector-metrics $bin/$COLLECTOR_BINARY_NAME
    mv $bin/scrutiny $bin/$WEB_BINARY_NAME
  '';

  doCheck = false;

  meta = with lib; {
    description = "Hard Drive S.M.A.R.T Monitoring, Historical Trends & Real World Failure Thresholds";
    homepage = "https://github.com/AnalogJ/scrutiny/";
    license = licenses.mit;
    maintainers = with maintainers; [ cameronfyfe ];
  };
}
