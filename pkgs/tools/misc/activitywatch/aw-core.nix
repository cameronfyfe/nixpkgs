{ lib, python3 }:
{ src, version, py-libs }:

python3.pkgs.buildPythonPackage rec {
  pname = "aw-core";

  format = "pyproject";

  inherit src version;

  # easiest to just patch this to use the newer tomlkit version that poetry pulls in
  postPatch = ''
    sed -i 's/tomlkit = "^0.6.0"/tomlkit = "*"/g' pyproject.toml
  '';

  propagatedBuildInputs = (with py-libs; [
    appdirs
    deprecation
    iso8601
    jsonschema
    peewee
    poetry
    python-json-logger
    rfc3339-validator
    strict-rfc3339
    TakeTheTime
    timeslot
  ]);

  meta = with lib; {
    description = "Core library for ActivityWatch.";
    homepage = "https://github.com/ActivityWatch/aw-core";
    license = licenses.mpl20;
    maintainers = with maintainers; [ cameronfyfe ];
  };
}
