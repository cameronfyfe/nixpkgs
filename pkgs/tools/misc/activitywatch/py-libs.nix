{ python3 }:

# some package versions can be grabbed from nixpkgs
{
  inherit (python3.pkgs)
    appdirs
    deprecation
    peewee
    poetry
    requests
    rfc3339-validator
    strict-rfc3339
    tabulate
    ;
}

  //

  # some package versions need to be built
rec {

  click = python3.pkgs.buildPythonPackage rec {
    pname = "click";
    version = "7.1.2";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "0rUlXHxjSbwb0eWeCM0SrLvWPOZJ8liHVXg6qU37axo=";
    };

    doCheck = false;
  };

  Flask = python3.pkgs.buildPythonPackage rec {
    pname = "Flask";
    version = "1.1.4";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "D762GA04OpGG0NbtlU4AQq2fGODo3giLK0GdUmkn0ZY=";
    };

    propagatedBuildInputs = [
      click
      itsdangerous
      Jinja2
      Werkzeug
    ] ++ (with python3.pkgs; [

    ]);

    doCheck = false;
  };

  Flask-Cors = python3.pkgs.buildPythonPackage rec {
    pname = "Flask-Cors";
    version = "3.0.10";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "tgg5OT87hKDzdG9s3KVsGtdCaqc4tw1sYTdYV4Ixgd4=";
    };

    propagatedBuildInputs = [
      Flask
    ] ++ (with python3.pkgs; [
      six
    ]);

    doCheck = false;
  };

  flask-restx = python3.pkgs.buildPythonPackage rec {
    pname = "flask-restx";
    version = "0.2.0";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "yoehgIMz9OxaUKV0C0TmzTh5pLlA1VnfOZaHfsSi8qU=";
    };

    propagatedBuildInputs = [
      Flask
      jsonschema
    ] ++ (with python3.pkgs; [
      aniso8601
      pytz
      six
    ]);

    doCheck = false;
  };

  iso8601 = python3.pkgs.buildPythonPackage rec {
    pname = "iso8601";
    version = "0.1.16";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "NlMvd8yABZTo8WZB7a5/G695MvBdjlCFRblfxTxtyFs=";
    };

    doCheck = false;
  };

  itsdangerous = python3.pkgs.buildPythonPackage rec {
    pname = "itsdangerous";
    version = "0.24";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "y7P8+NPjPfhhcJ7K+J2eZinP8KIXvChI8bQc0w02BRk=";
    };

    doCheck = false;
  };

  Jinja2 = python3.pkgs.buildPythonPackage rec {
    pname = "Jinja2";
    version = "2.11.3";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "ptWEM94K6AA0fKsfowQ867q+i6qdKeZo8cdoy4ejM8Y=";
    };

    propagatedBuildInputs = with python3.pkgs; [
      markupsafe
    ];

    doCheck = false;
  };

  jsonschema = python3.pkgs.buildPythonPackage rec {
    pname = "jsonschema";
    version = "3.1.1";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "L6BoQna2Mz/zwLGycIH0sjBfCjbPcCoj21DtsUGJPD8=";
    };

    nativeBuildInputs = with python3.pkgs; [
      setuptools-scm
    ];

    propagatedBuildInputs = with python3.pkgs; [
      attrs
      importlib-metadata
      pyrsistent
    ];

    doCheck = false;
  };

  persist-queue = python3.pkgs.buildPythonPackage rec {
    pname = "persist-queue";
    version = "0.6.0";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "5z3WJUXTflGSR9ljaL+lxRD95mmZozjW0tRHkNwQ+Js=";
    };

    doCheck = false;
  };

  TakeTheTime = python3.pkgs.buildPythonPackage rec{
    pname = "TakeTheTime";
    version = "0.3.1";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "2+MEU6G1lqOPni4/qOGtxa8tv2RsoIN61cIFmhb+L/k=";
    };

    doCheck = false;
  };

  timeslot = python3.pkgs.buildPythonPackage rec {
    pname = "timeslot";
    version = "0.1.2";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "oqyZhlfj87nKkodXtJBq3SwFOQxfwU7XkruQKNCFR7E=";
    };

    doCheck = false;
  };

  python-json-logger = python3.pkgs.buildPythonPackage rec {
    pname = "python-json-logger";
    version = "0.1.11";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "t6MRYvKgGWWl77lEU85pIw7SCEaLC7x/38VubY3y4oE=";
    };

    doCheck = false;
  };

  pynput = python3.pkgs.buildPythonPackage rec {
    pname = "pynput";
    version = "1.7.6";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "OlcmVG2lQRa2h3hdOLHbVpl84dKOU+jSL8ZW2LkuUzw=";
    };

    nativeBuildInputs = with python3.pkgs; [
      sphinx
    ];

    propagatedBuildInputs = [
      python-xlib
    ] ++ (with python3.pkgs; [
      evdev
      setuptools-lint
    ]);

    doCheck = false;
  };

  python-xlib = python3.pkgs.buildPythonPackage rec {
    pname = "python-xlib";
    version = "0.28";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "Ql92YXPNsw0NYbQWNC6+zzEqG/FsTXLs0msEZnSWBn8=";
    };

    nativeBuildInputs = with python3.pkgs; [
      setuptools-scm
    ];

    propagatedBuildInputs = with python3.pkgs; [
      six
    ];

    doCheck = false;
  };

  Werkzeug = python3.pkgs.buildPythonPackage rec {
    pname = "Werkzeug";
    version = "1.0.1";

    src = python3.pkgs.fetchPypi {
      inherit pname version;
      sha256 = "bICx5a02ZSkOo5MguR4b4eDV9gZSuWSjBwIW3oPS5Hw=";
    };

    doCheck = false;
  };

}
