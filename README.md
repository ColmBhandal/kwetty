# kwetty

POC using [Wetty](https://github.com/butlerx/wetty) to expose an interactive browser-based terminal for the K language.

# Prerequisites

 - Assumes you have Docker installed and the Docker daemon running

# Use

 - From the root directory of this repo, run: ``docker compose up``
- Open a web browser
 - Visit ``http://URL:3000/wetty`` where ``URL`` is the URL of the machine on which you ran the ``docker compose up`` command. If on the same machine as your browser, then just visit ``http://localhost:3000/wetty``
 - Login with credentials ``kdoctor:k``
 - Start running ``K`` commands from your browser!

# Explanation

Kwetty runs two services: ``K`` and ``Wetty``.

## ``K`` Service

The ``K`` service is a slightly modified version of this [K image](https://hub.docker.com/layers/kframework-k/runtimeverificationinc/kframework-k/ubuntu-focal-release/images/sha256-04d22aa70157e928bf18a58ca5facd387b03ff193489894e7e5acef4c17cb64e?context=explore). The modifications made are to add a user called ``kdoctor`` with a password of ``k`` and then launch an ``ssh`` server on startup. Some tinkering with ``ssh`` settings was also necessary here to allow for credential-based login.

## The Wetty Service

This is just OOTB [Wetty](https://github.com/butlerx/wetty). The only thing we configure is that it connects to the ``K`` service over ssh and then we expose its port ``3000`` so that web-browsers can visit the Wetty UI.

