{ lib, python3 }:
{ src, version, py-libs, aw-core }:

python3.pkgs.buildPythonPackage {
  pname = "aw-client";

  format = "pyproject";

  inherit src version;

  propagatedBuildInputs = [
    aw-core
  ] ++ (with py-libs; [
    click
    persist-queue
    poetry
    requests
    tabulate
  ]);

  meta = with lib; {
    description = "Client library for ActivityWatch in Python.";
    homepage = "https://github.com/ActivityWatch/aw-client";
    license = licenses.mpl20;
    maintainers = with maintainers; [ cameronfyfe ];
  };
}
