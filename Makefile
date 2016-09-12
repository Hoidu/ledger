URL=http://127.0.0.1:5000

.DEFAULT: test

.PHONY: precommit
precommit: pep8 test

.PHONY: pep8
pep8:
	pep8 --max-line-length=80 ledger.py ledger_test.py

.PHONY: test
test:
	python ledger_test.py

.PHONY: setup
setup:
	ln -sf ../../precommit ./.git/hooks/pre-commit

.PHONY: seed
seed:
	curl -H "Content-Type: application/json" -X POST -d '{"name":"Cash","code":"101","type":"asset"}' "${URL}/accounts"
	curl -H "Content-Type: application/json" -X POST -d '{"name":"Equipment","code":"102","type":"asset"}' "${URL}/accounts"
	curl -H "Content-Type: application/json" -X POST -d '{"name":"Bank Loan","code":"201","type":"liability"}' "${URL}/accounts"
	curl -H "Content-Type: application/json" -X POST -d '{"name":"Share Capital","code":"301","type":"equity"}' "${URL}/accounts"
	curl -H "Content-Type: application/json" -X POST -d '{"date":"2016-09-01","description":"Record the initial investment","items":[{"account_code":"101","amount":100000},{"account_code":"301","amount":-100000}]}' "${URL}/transactions"
	curl -H "Content-Type: application/json" -X POST -d '{"date":"2016-09-03","description":"Buy a computer","items":[{"account_code":"101","amount":-50000},{"account_code":"102","amount":200000},{"account_code":"201","amount":-150000}]}' "${URL}/transactions"
