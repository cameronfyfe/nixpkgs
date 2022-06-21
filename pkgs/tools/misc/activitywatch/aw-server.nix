{ lib, python3 }:
{ src, version, py-libs, aw-client, aw-webui }:

python3.pkgs.buildPythonApplication {
  name = "aw-server";

  format = "pyproject";

  inherit src version;

  preBuild = ''
    mkdir -p aw_server/static
    cp -r ${aw-webui}/* aw_server/static/
  '';

  propagatedBuildInputs = [
    aw-client
  ] ++ (with py-libs; [
    Flask
    Flask-Cors
    flask-restx
    poetry
    pynput
    setuptools
  ]);

  meta = with lib; {
    description = "ActivityWatch server, for secure storage and retrieval of all your Quantified Self data.";
    homepage = "https://github.com/ActivityWatch/aw-server";
    license = licenses.mpl20;
    maintainers = with maintainers; [ cameronfyfe ];
  };
}
