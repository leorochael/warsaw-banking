
prep: var/lib/apt/lists var/cache/apt/archives root/artifacts/warsaw_setup_64.deb root/artifacts/firefox_cert_override-0.1.1-py3-none-any.whl

root/artifacts/warsaw_setup_64.deb:
	mkdir -p root/artifacts
	cd root/artifacts && wget https://cloud.gastecnologia.com.br/gas/diagnostico/warsaw_setup_64.deb

root/artifacts/firefox_cert_override-0.1.1-py3-none-any.whl:
	mkdir -p root/artifacts
	cd root/artifacts && wget https://files.pythonhosted.org/packages/c5/03/ddeaa4460a840330c2480646d95382b03a756cac7f8a3c0225ac86c48732/firefox_cert_override-0.1.1-py3-none-any.whl

var/%:
	mkdir -p $@