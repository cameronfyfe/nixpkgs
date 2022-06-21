{ lib, python3 }:
{ src, version, py-libs, aw-client }:

python3.pkgs.buildPythonApplication {
  name = "aw-watcher-afk";

  format = "pyproject";

  inherit src version;

  propagatedBuildInputs = [
    aw-client
  ] ++ (with py-libs; [
    poetry
    python-xlib
    pynput
    setuptools
  ]);

  meta = with lib; {
    description = "Watches your keyboard and mouse activity to determine if you are AFK or not.";
    homepage = "https://github.com/ActivityWatch/aw-watcher-afk";
    license = licenses.mpl20;
    maintainers = with maintainers; [ cameronfyfe ];
  };
}
