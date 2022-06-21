{ lib, stdenv }:
{ version }:

stdenv.mkDerivation {
  pname = "aw-webui";

  inherit version;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out
    cp -r ${./dist}/* $out/
  '';

  meta = with lib; {
    description = "A web-based UI for ActivityWatch, built with Vue.js";
    homepage = "https://github.com/ActivityWatch/aw-webui";
    license = licenses.mpl20;
    maintainers = with maintainers; [ cameronfyfe ];
  };
}
