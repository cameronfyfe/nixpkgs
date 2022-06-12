{ python3 }:
{ src, version, py-libs, aw-client }:

python3.pkgs.buildPythonApplication {
  name = "aw-watcher-window";

  format = "pyproject";

  inherit src version;

  nativeBuildInputs = [
    py-libs.poetry
  ];

  propagatedBuildInputs = [
    aw-client
  ] ++ (with py-libs; [
    python-xlib
  ]);
}
