{ python3 }:
{ src, version, py-libs, aw-core }:

python3.pkgs.buildPythonPackage {
  pname = "aw-client";

  format = "pyproject";

  inherit src version;

  nativeBuildInputs = [
    py-libs.poetry
  ];

  propagatedBuildInputs = [
    aw-core
  ] ++ (with py-libs; [
    click
    persist-queue
    requests
    tabulate
  ]);
}
