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

  vendorSha256 = "sha256-+8dXfqOu8XTw2uEx3GAynQSHtzifejZtddr1CdxrupA=";

  doCheck = false;

  meta = with lib; {
    description = "Command output timestamp";
    homepage = "https://github.com/zmwangx/ets/";
    license = licenses.mit;
    maintainers = with maintainers; [ cameronfyfe ];
  };
}
