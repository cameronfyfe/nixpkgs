{ lib
, fetchCrate
, rustPlatform
}:

rustPlatform.buildRustPackage rec {
  pname = "lurk";
  version = "0.2.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "GtCwrNOyG1rIlP8vHDTlLwEjKSIuslmT5e9GPmCmazU=";
  };

  cargoSha256 = "9MjoRx0EviCzFL713jfIzGH/Bu37Pbeg3BsQLgIIySc=";

  doCheck = true;

  meta = with lib; {
    description = "Lurk is a Turing-complete programming language for recursive zk-SNARKs";
    homepage = "https://lurk-lang.org";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ cameronfyfe ];
  };
}

