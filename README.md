# Kwetty

This is a POC using [Wetty](https://github.com/butlerx/wetty) to expose an interactive browser-based terminal for the K language. The POC was inspired by the [K Online Scratchpad Issue](https://github.com/runtimeverification/k/issues/2541#issuecomment-1100265089) on the ``K`` website. This is similar to how [Docker Playground](https://labs.play-with-docker.com/) exposes a terminal session, allowing people to play with Docker without installing anything.

# This is a POC Only

Right now, there is no intention to continue development on this project. It is just one example of how one could expose ``K`` over a web browser, exposing a terminal session in the browser. Long-term, it is hoped that a more thorough solution emerges from the [K Online Scratchpad Issue](https://github.com/runtimeverification/k/issues/2541#issuecomment-1100265089) e.g. something akin to Jupyter Notebooks for ``K``.

# Running Kwetty

These steps explain how to run Kwetty on a machine with Docker installed and the Docker daemon running:
 - Check out this repository
 - From the root directory of this repo, run: ``docker compose up``

# Use

These steps explain how to access Kwetty through a web-browswer:

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

## Are Two Services Really Necessary?

It is certainly possible that instead of having ``K`` and ``Wetty`` running as separate servicese, there could be just a single service that runs ``Kwetty``. It's likely that this would be less resource intensive. Here are two ways one could merge ``K`` and ``Wetty`` into a single image:

 - Start with the ``K`` image, install ``Wetty`` on top of that via a ``Dockerfile`` to get a single ``Kwetty`` image.
 - Start with ``Wetty`` and install ``K`` on top of that via a ``Dockerfile`` to get a single ``Kwetty`` image.

Note: such approaches would need to take into account the fact that ``K`` is Ubuntu-based while ``Wetty`` is Alpine-based.
