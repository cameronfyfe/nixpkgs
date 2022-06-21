{ python3 }:

let

  inherit (python3.pkgs)
    buildPythonPackage
    fetchPypi
    ;

in

rec {

  # some package versions can be grabbed from nixpkgs

  inherit (python3.pkgs)
    aniso8601
    attrs
    appdirs
    deprecation
    evdev
    importlib-metadata
    peewee
    poetry
    pyrsistent
    pytz
    requests
    rfc3339-validator
    setuptools
    setuptools-lint
    setuptools-scm
    six
    sphinx
    strict-rfc3339
    tabulate
    ;

  # some package versions need to be built

  click = buildPythonPackage rec {
    pname = "click";
    version = "7.1.2";

    src = fetchPypi {
      inherit pname version;
      sha256 = "0rUlXHxjSbwb0eWeCM0SrLvWPOZJ8liHVXg6qU37axo=";
    };

    doCheck = false;
  };

  Flask = buildPythonPackage rec {
    pname = "Flask";
    version = "1.1.4";

    src = fetchPypi {
      inherit pname version;
      sha256 = "D762GA04OpGG0NbtlU4AQq2fGODo3giLK0GdUmkn0ZY=";
    };

    propagatedBuildInputs = [
      click
      itsdangerous
      Jinja2
      Werkzeug
    ];

    doCheck = false;
  };

  Flask-Cors = buildPythonPackage rec {
    pname = "Flask-Cors";
    version = "3.0.10";

    src = fetchPypi {
      inherit pname version;
      sha256 = "tgg5OT87hKDzdG9s3KVsGtdCaqc4tw1sYTdYV4Ixgd4=";
    };

    propagatedBuildInputs = [
      Flask
      six
    ];

    doCheck = false;
  };

  flask-restx = buildPythonPackage rec {
    pname = "flask-restx";
    version = "0.2.0";

    src = fetchPypi {
      inherit pname version;
      sha256 = "yoehgIMz9OxaUKV0C0TmzTh5pLlA1VnfOZaHfsSi8qU=";
    };

    propagatedBuildInputs = [
      aniso8601
      Flask
      jsonschema
      pytz
      six
    ];

    doCheck = false;
  };

  iso8601 = buildPythonPackage rec {
    pname = "iso8601";
    version = "0.1.16";

    src = fetchPypi {
      inherit pname version;
      sha256 = "NlMvd8yABZTo8WZB7a5/G695MvBdjlCFRblfxTxtyFs=";
    };

    doCheck = false;
  };

  itsdangerous = buildPythonPackage rec {
    pname = "itsdangerous";
    version = "0.24";

    src = fetchPypi {
      inherit pname version;
      sha256 = "y7P8+NPjPfhhcJ7K+J2eZinP8KIXvChI8bQc0w02BRk=";
    };

    doCheck = false;
  };

  Jinja2 = buildPythonPackage rec {
    pname = "Jinja2";
    version = "2.11.3";

    src = fetchPypi {
      inherit pname version;
      sha256 = "ptWEM94K6AA0fKsfowQ867q+i6qdKeZo8cdoy4ejM8Y=";
    };

    propagatedBuildInputs = [
      MarkupSafe
    ];

    doCheck = false;
  };

  jsonschema = buildPythonPackage rec {
    pname = "jsonschema";
    version = "3.1.1";

    src = fetchPypi {
      inherit pname version;
      sha256 = "L6BoQna2Mz/zwLGycIH0sjBfCjbPcCoj21DtsUGJPD8=";
    };

    propagatedBuildInputs = [
      attrs
      importlib-metadata
      pyrsistent
      setuptools-scm
    ];

    doCheck = false;
  };

  MarkupSafe = buildPythonPackage rec {
    pname = "MarkupSafe";
    version = "2.0.1";

    src = fetchPypi {
      inherit pname version;
      sha256 = "WUxngH+xYjizDES99082wCzfItHIzake+KDtjav1Ygo=";
    };

    doCheck = false;
  };

  persist-queue = buildPythonPackage rec {
    pname = "persist-queue";
    version = "0.6.0";

    src = fetchPypi {
      inherit pname version;
      sha256 = "5z3WJUXTflGSR9ljaL+lxRD95mmZozjW0tRHkNwQ+Js=";
    };

    doCheck = false;
  };

  TakeTheTime = buildPythonPackage rec{
    pname = "TakeTheTime";
    version = "0.3.1";

    src = fetchPypi {
      inherit pname version;
      sha256 = "2+MEU6G1lqOPni4/qOGtxa8tv2RsoIN61cIFmhb+L/k=";
    };

    doCheck = false;
  };

  timeslot = buildPythonPackage rec {
    pname = "timeslot";
    version = "0.1.2";

    src = fetchPypi {
      inherit pname version;
      sha256 = "oqyZhlfj87nKkodXtJBq3SwFOQxfwU7XkruQKNCFR7E=";
    };

    doCheck = false;
  };

  python-json-logger = buildPythonPackage rec {
    pname = "python-json-logger";
    version = "0.1.11";

    src = fetchPypi {
      inherit pname version;
      sha256 = "t6MRYvKgGWWl77lEU85pIw7SCEaLC7x/38VubY3y4oE=";
    };

    doCheck = false;
  };

  pynput = buildPythonPackage rec {
    pname = "pynput";
    version = "1.7.6";

    src = fetchPypi {
      inherit pname version;
      sha256 = "OlcmVG2lQRa2h3hdOLHbVpl84dKOU+jSL8ZW2LkuUzw=";
    };

    nativeBuildInputs = [
      sphinx
    ];

    propagatedBuildInputs = [
      evdev
      python-xlib
      setuptools-lint
    ];

    doCheck = false;
  };

  python-xlib = buildPythonPackage rec {
    pname = "python-xlib";
    version = "0.28";

    src = fetchPypi {
      inherit pname version;
      sha256 = "Ql92YXPNsw0NYbQWNC6+zzEqG/FsTXLs0msEZnSWBn8=";
    };

    propagatedBuildInputs = [
      setuptools-scm
      six
    ];

    doCheck = false;
  };

  Werkzeug = buildPythonPackage rec {
    pname = "Werkzeug";
    version = "1.0.1";

    src = fetchPypi {
      inherit pname version;
      sha256 = "bICx5a02ZSkOo5MguR4b4eDV9gZSuWSjBwIW3oPS5Hw=";
    };

    doCheck = false;
  };

}
