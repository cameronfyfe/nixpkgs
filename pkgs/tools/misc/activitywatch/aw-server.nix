{ python3 }:
{ src, version, py-libs, aw-client, aw-webui }:

python3.pkgs.buildPythonApplication {
  name = "aw-server";

  format = "pyproject";

  inherit src version;

  nativeBuildInputs = [
    py-libs.poetry
  ];

  preBuild = ''
    mkdir -p aw_server/static
    cp -r ${aw-webui}/dist/* aw_server/static/
  '';

  propagatedBuildInputs = [
    aw-client
  ] ++ (with py-libs; [
    Flask
    Flask-Cors
    flask-restx
    pynput
  ]);
}
