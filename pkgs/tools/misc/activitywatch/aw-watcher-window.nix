{ lib, python3 }:
{ src, version, py-libs, aw-client }:

python3.pkgs.buildPythonApplication {
  name = "aw-watcher-window";

  format = "pyproject";

  inherit src version;

  propagatedBuildInputs = [
    aw-client
  ] ++ (with py-libs; [
    poetry
    python-xlib
    setuptools
  ]);

  meta = with lib; {
    description = "Cross-platform window-Watcher for Linux (X11), macOS, Windows.";
    homepage = "https://github.com/ActivityWatch/aw-watcher-window";
    license = licenses.mpl20;
    maintainers = with maintainers; [ cameronfyfe ];
  };
}
