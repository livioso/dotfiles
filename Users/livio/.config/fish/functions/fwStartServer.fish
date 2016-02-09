function fwStartServer
	j fw-python
    . ../env/bin/activate.fish
    set -x PYTHONPATH .
    python -m frontend.manage runserver 0.0.0.0:8000 --configuration 'Development'
end
